import 'package:drift/drift.dart';

class Stock extends Table {
  TextColumn get name => text()();
  TextColumn get isin => text()();
  TextColumn get currency => text().nullable()();

  @override
  Set<Column> get primaryKey => { isin };
}

class StockDetail extends Table {
  TextColumn get stockIsin => text().references(Stock, #isin)();

  DateTimeColumn get date => dateTime()();

  RealColumn get openValue => real()();
  RealColumn get highValue => real()();
  RealColumn get lowValue => real()();
  RealColumn get closeValue => real()();

  RealColumn get change => real()(); // zmiana
  IntColumn get volume => integer()(); // wolumen
  IntColumn get transactions => integer()(); // liczba transakcji
  RealColumn get turnover => real()(); // obrot
  
  IntColumn get openInterest => integer()(); // liczba otwartych pozycji
  RealColumn get openInterestValue => real()(); // wartosc otwartych pozycji
  RealColumn get nominalValue => real()(); // cena nominalna

  @override
  Set<Column> get primaryKey => { stockIsin, date };
}
