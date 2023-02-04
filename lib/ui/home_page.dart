import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:drift/drift.dart';
import 'package:fast_csv/fast_csv.dart' as fing_fast_csv;

import 'package:spgpw/database/database.dart';
import 'package:spgpw/ui/stock_detail_page.dart';
import 'package:spgpw/ui/compare_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SpgpwDatabase _db;
  final _searchController = TextEditingController();

  List<StockData> _stocks = [];

  @override
  void initState() {
    super.initState();
    _db = SpgpwDatabase();
  }

  @override
  void dispose() {
    _db.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {});
            },
            controller: _searchController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(15),
              hintText: 'Search for stocks',
            ),
          ),
        ),
      ),

      body: FutureBuilder<List<StockData>>(
        future: _db.getAllStocks(filter: _searchController.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done || !snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text(snapshot.error.toString()));
          if (snapshot.data!.isEmpty) return const Center(child: Text('No stocks found'));
          _stocks = snapshot.data!;
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final stock = snapshot.data![index];
              return ListTile(
                title: Text(stock.name),
                subtitle: Text(stock.isin),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await _db.deleteStock(stock.isin).then((value) => debugPrint('Stock ${stock.name} has been deleted'));
                    setState(() {});
                  },
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StockDetailPage(_db, stock);
                  }));
                },
              );
            },
          );
        },
      ),

      floatingActionButton: Wrap(direction: Axis.vertical, children: [
        Container(margin: const EdgeInsets.only(bottom: 10), child:
        FloatingActionButton(
          heroTag: 'compare',
          child: const Icon(Icons.compare),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ComparePage(_db, _stocks);
            }));
          }
        )),
        FloatingActionButton(
          child: const Icon(Icons.add_box_rounded),
          onPressed: () async {
            _loadCsv();
          }
        ),
      ]),
    );
  }

  void _loadCsv() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result == null) return;

    String filepath = result.files.single.path!;
    debugPrint(filepath);
    File f = File(filepath);
    
    // when using csv package
    // final csv = const CsvToListConverter().convert(f.readAsStringSync(), eol: '\n');

    // when using fast_csv package
    final csv = fing_fast_csv.parse(f.readAsStringSync());

    csv.removeAt(0);

    List<StockCompanion> stocks = [];
    List<StockDetailCompanion> details = [];

    for (var l in csv) {
      stocks.add(StockCompanion(
        name: Value<String>(l[1].toString()),
        isin: Value<String>(l[2].toString()),
        currency: Value<String>(l[3].toString()),
      ));

      details.add(StockDetailCompanion(
        stockIsin: Value<String>(l[2]),
        date: Value<DateTime>(DateTime.parse(l[0].toString())),

        openValue: Value<double>(double.parse(l[4].toString())),
        highValue: Value<double>(double.parse(l[5].toString())),
        lowValue: Value<double>(double.parse(l[6].toString())),
        closeValue: Value<double>(double.parse(l[7].toString())),
        
        change: Value<double>(double.parse(l[8].toString())),
        volume: Value<int>(int.parse(l[9].toString())),
        transactions: Value<int>(int.parse(l[10].toString())),
        turnover: Value<double>(double.parse(l[11].toString())),

        // gpw guys are dumb as duck and mess this values up
        openInterest: Value<int>(int.tryParse((l[12].toString())) ?? 0),
        openInterestValue: Value<double>(double.tryParse(l[13].toString()) ?? 0),
        nominalValue: Value<double>(double.tryParse(l[14].toString()) ?? 0),
      ));
    }

    await _db.insertStocks(stocks).then((value) => setState(() {}));
    await _db.insertStockDetails(details);
  }
}
