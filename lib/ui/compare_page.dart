import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'package:spgpw/database/database.dart';

class ComparePage extends StatefulWidget {
  final SpgpwDatabase _db;
  final List<StockData> _stocks;

  @override
  ComparePage(this._db, this._stocks);

  @override
  _ComparePageState createState() => _ComparePageState(_db, _stocks);
}

class _Mapper {
  int openValue = 0;
  int highValue = 0;
  int lowValue = 0;
  int closeValue = 1;

  int change = 0;
  int volume = 0;
  int transactions = 0;
  int turnover = 0;

  int openInterest = 0;
  int openInterestValue = 0;
  int nominalValue = 0;

  int selected = 1;

  _Mapper();

  // return average from selected values
  map(StockDetailData d) => (
      d.openValue * openValue 
    + d.highValue * highValue 
    + d.lowValue * lowValue
    + d.closeValue * closeValue
    + d.change * change
    + d.volume * volume
    + d.transactions * transactions
    + d.turnover * turnover
    + d.openInterest * openInterest
    + d.openInterestValue * openInterestValue
    + d.nominalValue * nominalValue
  ) / (selected == 0 ? 1 : selected);
}

class _ComparePageState extends State<ComparePage> {
  final SpgpwDatabase _db;
  final List<StockData> _stocks;

  List<StockData> _selected = [];

  static DateTime _from = DateTime.parse("1991-01-01");
  static DateTime _to = DateTime.now();
  static _Mapper mapper = _Mapper();

  static final _zoomPanBehavior = ZoomPanBehavior(
    enablePanning: true,
    enablePinching: true,
    enableMouseWheelZooming: true,
  );

  static final _tooltipBehavior = TooltipBehavior(enable: true);

  _ComparePageState(this._db, this._stocks);

  makeLineSeries(String name, List<StockDetailData> data) =>
    FastLineSeries<StockDetailData, DateTime>(
      name: name,
      dataSource: data,
      xValueMapper: (StockDetailData d, _) => d.date,
      yValueMapper: (StockDetailData d, _) => mapper.map(d),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Compare Stocks"),
      ),

      body: FutureBuilder<List<List<StockDetailData>>>(
        future: Future.wait(_selected.map((s) => _db.getStockDetailsFromRange(s.isin, _from, _to))),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done || !snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text(snapshot.error.toString()));
          if (snapshot.data!.isEmpty) return const Center(child: Text('No selected stocks'));

          List<ChartSeries> series = [];
          for (var i = 0; i < _selected.length; i++) {
            series.add(makeLineSeries(_selected[i].name, snapshot.data![i]));
          }

          var currency = _selected.first.currency;

          return SfCartesianChart(
            legend: Legend(isVisible: true),
            primaryXAxis: DateTimeAxis(),
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.currency(name: currency, decimalDigits: 0),
            ),
            zoomPanBehavior: _zoomPanBehavior,
            tooltipBehavior: _tooltipBehavior,
            series: series
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.addchart),
        onPressed: () async {
          var stocks = await showDialog<List<StockData>>(
            context: context,
            builder: (context) => _SelectStocksDialog(_stocks, _selected),
          );
          setState(() {}); // TODO: only update if_selected changed
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,

      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            MaterialButton(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("Start date"),
              ),
              onPressed: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: _from,
                  firstDate: DateTime.parse("1991-01-01"),
                  lastDate: _to,
                );
                if (date != null) setState(() { _from = date; });
              },
            ),

            MaterialButton(
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("End date"),
              ),
              onPressed: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: _to,
                  firstDate: _from,
                  lastDate: DateTime.now(),
                );
                if (date != null) setState(() { _to = date; });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// WARN: I don't really know what this code does but it seems to work
class _SelectStocksDialog extends StatefulWidget {
  final List<StockData> _stocks;
  final List<StockData> _selected;

  _SelectStocksDialog(this._stocks, this._selected);

  @override
  _SelectStocksDialogState createState() => _SelectStocksDialogState(_stocks, _selected);
}

class _SelectStocksDialogState extends State<_SelectStocksDialog> {
  final List<StockData> _stocks;
  final List<StockData> _selected;

  _SelectStocksDialogState(this._stocks, this._selected);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select stocks"),
      content: SizedBox(
        height: 300,
        width: 300,
        child: ListView.builder(
          itemCount: _stocks.length,
          itemBuilder: (context, index) {
            var stock = _stocks[index];
            return CheckboxListTile(
              title: Text(stock.name),
              value: _selected.contains(stock),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _selected.add(stock);
                  } else {
                    _selected.remove(stock);
                  }
                });
              },
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
