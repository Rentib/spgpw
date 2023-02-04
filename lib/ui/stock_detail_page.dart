import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import 'package:spgpw/database/database.dart';

class StockDetailPage extends StatefulWidget {
  final SpgpwDatabase _db;
  final StockData _stock;

  StockDetailPage(this._db, this._stock);

  @override
  _StockDetailPageState createState() => _StockDetailPageState(_db, _stock);
}

class _StockDetailPageState extends State<StockDetailPage> {
  final SpgpwDatabase _db;
  final StockData _stock;

  static DateTime _from = DateTime.parse("1991-01-01");
  static DateTime _to = DateTime.now();

  static final _zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    enablePanning: true,
    enableMouseWheelZooming: true,
  );

  static final _tooltipBehavior = TooltipBehavior(enable: true);

  _StockDetailPageState(this._db, this._stock);

  _makeCandleSeries(List<StockDetailData> data) =>
    CandleSeries<StockDetailData, DateTime>(
      name: _stock.name,
      dataSource: data,
      xValueMapper: (StockDetailData d, _) => d.date,
      lowValueMapper: (StockDetailData d, _) => d.lowValue,
      highValueMapper: (StockDetailData d, _) => d.highValue,
      openValueMapper: (StockDetailData d, _) => d.openValue,
      closeValueMapper: (StockDetailData d, _) => d.closeValue,
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_stock.name),
      ),

      body: FutureBuilder<List<StockDetailData>>(
        future: _db.getStockDetailsFromRange(_stock.isin, _from, _to),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done || !snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text(snapshot.error.toString()));
          if (snapshot.data!.isEmpty) return const Center(child: Text('No stocks found'));

          var data = snapshot.data!;

          return SfCartesianChart(
            series: <CandleSeries>[ _makeCandleSeries(data) ],
            primaryXAxis: DateTimeAxis(),
            primaryYAxis: NumericAxis(
              numberFormat: NumberFormat.currency(name: _stock.currency, decimalDigits: 0),
            ),
            zoomPanBehavior: _zoomPanBehavior,
            tooltipBehavior: _tooltipBehavior,
          );
        }
      ),

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
