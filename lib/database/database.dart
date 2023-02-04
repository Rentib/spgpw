import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:spgpw/database/tables.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'spgpw.db'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Stock, StockDetail])
class SpgpwDatabase extends _$SpgpwDatabase {
  SpgpwDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<StockData>> getAllStocks({String? filter}) async {
    return filter != null ?
      await (select(stock)..
             where((t) => t.name.like('%$filter%'))..
             orderBy([(t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)])).get()
    : await (select(stock)..
             orderBy([(t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc)])).get();
  }

  Future<StockData> getStock(String isin) async {
    return await (select(stock)..where((t) => t.isin.equals(isin))).getSingle();
  }

  Future<int> insertStock(StockCompanion entry) async {
    return await into(stock).insert(entry, mode: InsertMode.insertOrReplace);
  }

  Future<void> insertStocks(List<StockCompanion> entries) async {
    await batch((batch) {
      batch.insertAll(stock, entries, mode: InsertMode.insertOrReplace);
    });
  }

  Future<int> deleteStock(String isin) async {
    return await (delete(stock)..where((t) => t.isin.equals(isin))).go();
  }

  Future<List<StockDetailData>> getAllStockDetails(String isin) async {
    return await (select(stockDetail)..where((t) => t.stockIsin.equals(isin))..
                  orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)])).get();
  }

  Future<StockDetailData> getStockDetail(String isin, DateTime date) async {
    return await (select(stockDetail)..where((t) => t.stockIsin.equals(isin) & t.date.equals(date))).getSingle();
  }

  Future<StockDetailData> getStockDetailMinDate(String isin) async {
    return await (
      select(stockDetail)..where((t) => t.stockIsin.equals(isin))..
      orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)])..
      limit(1)
    ).getSingle();
  }

  Future<StockDetailData> getStockDetailMaxDate(String isin) async {
    return await (
      select(stockDetail)..where((t) => t.stockIsin.equals(isin))..
      orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])..
      limit(1)
    ).getSingle();
  }

  Future<List<StockDetailData>> getStockDetailsFromRange(String isin, DateTime from, DateTime to) async {
    return await (select(stockDetail)..where((t) => t.stockIsin.equals(isin) & t.date.isBetweenValues(from, to))..
                  orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.asc)])).get();
  }

  Future<int> insertStockDetail(StockDetailCompanion entry) async {
    return await into(stockDetail).insert(entry, mode: InsertMode.insertOrReplace);
  }

  Future<void> insertStockDetails(List<StockDetailCompanion> entries) async {
    await batch((batch) {
      batch.insertAll(stockDetail, entries, mode: InsertMode.insertOrReplace);
    });
  }

  Future<int> deleteStockDetail(String isin, DateTime date) async {
    return await (delete(stockDetail)..where((t) => t.stockIsin.equals(isin) & t.date.equals(date))).go();
  }
}
