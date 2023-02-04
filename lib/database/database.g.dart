// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $StockTable extends Stock with TableInfo<$StockTable, StockData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isinMeta = const VerificationMeta('isin');
  @override
  late final GeneratedColumn<String> isin = GeneratedColumn<String>(
      'isin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currencyMeta =
      const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
      'currency', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [name, isin, currency];
  @override
  String get aliasedName => _alias ?? 'stock';
  @override
  String get actualTableName => 'stock';
  @override
  VerificationContext validateIntegrity(Insertable<StockData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('isin')) {
      context.handle(
          _isinMeta, isin.isAcceptableOrUnknown(data['isin']!, _isinMeta));
    } else if (isInserting) {
      context.missing(_isinMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta,
          currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {isin};
  @override
  StockData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockData(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}isin'])!,
      currency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency']),
    );
  }

  @override
  $StockTable createAlias(String alias) {
    return $StockTable(attachedDatabase, alias);
  }
}

class StockData extends DataClass implements Insertable<StockData> {
  final String name;
  final String isin;
  final String? currency;
  const StockData({required this.name, required this.isin, this.currency});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['isin'] = Variable<String>(isin);
    if (!nullToAbsent || currency != null) {
      map['currency'] = Variable<String>(currency);
    }
    return map;
  }

  StockCompanion toCompanion(bool nullToAbsent) {
    return StockCompanion(
      name: Value(name),
      isin: Value(isin),
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
    );
  }

  factory StockData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockData(
      name: serializer.fromJson<String>(json['name']),
      isin: serializer.fromJson<String>(json['isin']),
      currency: serializer.fromJson<String?>(json['currency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'isin': serializer.toJson<String>(isin),
      'currency': serializer.toJson<String?>(currency),
    };
  }

  StockData copyWith(
          {String? name,
          String? isin,
          Value<String?> currency = const Value.absent()}) =>
      StockData(
        name: name ?? this.name,
        isin: isin ?? this.isin,
        currency: currency.present ? currency.value : this.currency,
      );
  @override
  String toString() {
    return (StringBuffer('StockData(')
          ..write('name: $name, ')
          ..write('isin: $isin, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, isin, currency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockData &&
          other.name == this.name &&
          other.isin == this.isin &&
          other.currency == this.currency);
}

class StockCompanion extends UpdateCompanion<StockData> {
  final Value<String> name;
  final Value<String> isin;
  final Value<String?> currency;
  const StockCompanion({
    this.name = const Value.absent(),
    this.isin = const Value.absent(),
    this.currency = const Value.absent(),
  });
  StockCompanion.insert({
    required String name,
    required String isin,
    this.currency = const Value.absent(),
  })  : name = Value(name),
        isin = Value(isin);
  static Insertable<StockData> custom({
    Expression<String>? name,
    Expression<String>? isin,
    Expression<String>? currency,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (isin != null) 'isin': isin,
      if (currency != null) 'currency': currency,
    });
  }

  StockCompanion copyWith(
      {Value<String>? name, Value<String>? isin, Value<String?>? currency}) {
    return StockCompanion(
      name: name ?? this.name,
      isin: isin ?? this.isin,
      currency: currency ?? this.currency,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isin.present) {
      map['isin'] = Variable<String>(isin.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockCompanion(')
          ..write('name: $name, ')
          ..write('isin: $isin, ')
          ..write('currency: $currency')
          ..write(')'))
        .toString();
  }
}

class $StockDetailTable extends StockDetail
    with TableInfo<$StockDetailTable, StockDetailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockDetailTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _stockIsinMeta =
      const VerificationMeta('stockIsin');
  @override
  late final GeneratedColumn<String> stockIsin = GeneratedColumn<String>(
      'stock_isin', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES stock (isin)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _openValueMeta =
      const VerificationMeta('openValue');
  @override
  late final GeneratedColumn<double> openValue = GeneratedColumn<double>(
      'open_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _highValueMeta =
      const VerificationMeta('highValue');
  @override
  late final GeneratedColumn<double> highValue = GeneratedColumn<double>(
      'high_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _lowValueMeta =
      const VerificationMeta('lowValue');
  @override
  late final GeneratedColumn<double> lowValue = GeneratedColumn<double>(
      'low_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _closeValueMeta =
      const VerificationMeta('closeValue');
  @override
  late final GeneratedColumn<double> closeValue = GeneratedColumn<double>(
      'close_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _changeMeta = const VerificationMeta('change');
  @override
  late final GeneratedColumn<double> change = GeneratedColumn<double>(
      'change', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<int> volume = GeneratedColumn<int>(
      'volume', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _transactionsMeta =
      const VerificationMeta('transactions');
  @override
  late final GeneratedColumn<int> transactions = GeneratedColumn<int>(
      'transactions', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _turnoverMeta =
      const VerificationMeta('turnover');
  @override
  late final GeneratedColumn<double> turnover = GeneratedColumn<double>(
      'turnover', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _openInterestMeta =
      const VerificationMeta('openInterest');
  @override
  late final GeneratedColumn<int> openInterest = GeneratedColumn<int>(
      'open_interest', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _openInterestValueMeta =
      const VerificationMeta('openInterestValue');
  @override
  late final GeneratedColumn<double> openInterestValue =
      GeneratedColumn<double>('open_interest_value', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _nominalValueMeta =
      const VerificationMeta('nominalValue');
  @override
  late final GeneratedColumn<double> nominalValue = GeneratedColumn<double>(
      'nominal_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        stockIsin,
        date,
        openValue,
        highValue,
        lowValue,
        closeValue,
        change,
        volume,
        transactions,
        turnover,
        openInterest,
        openInterestValue,
        nominalValue
      ];
  @override
  String get aliasedName => _alias ?? 'stock_detail';
  @override
  String get actualTableName => 'stock_detail';
  @override
  VerificationContext validateIntegrity(Insertable<StockDetailData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('stock_isin')) {
      context.handle(_stockIsinMeta,
          stockIsin.isAcceptableOrUnknown(data['stock_isin']!, _stockIsinMeta));
    } else if (isInserting) {
      context.missing(_stockIsinMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('open_value')) {
      context.handle(_openValueMeta,
          openValue.isAcceptableOrUnknown(data['open_value']!, _openValueMeta));
    } else if (isInserting) {
      context.missing(_openValueMeta);
    }
    if (data.containsKey('high_value')) {
      context.handle(_highValueMeta,
          highValue.isAcceptableOrUnknown(data['high_value']!, _highValueMeta));
    } else if (isInserting) {
      context.missing(_highValueMeta);
    }
    if (data.containsKey('low_value')) {
      context.handle(_lowValueMeta,
          lowValue.isAcceptableOrUnknown(data['low_value']!, _lowValueMeta));
    } else if (isInserting) {
      context.missing(_lowValueMeta);
    }
    if (data.containsKey('close_value')) {
      context.handle(
          _closeValueMeta,
          closeValue.isAcceptableOrUnknown(
              data['close_value']!, _closeValueMeta));
    } else if (isInserting) {
      context.missing(_closeValueMeta);
    }
    if (data.containsKey('change')) {
      context.handle(_changeMeta,
          change.isAcceptableOrUnknown(data['change']!, _changeMeta));
    } else if (isInserting) {
      context.missing(_changeMeta);
    }
    if (data.containsKey('volume')) {
      context.handle(_volumeMeta,
          volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta));
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    if (data.containsKey('transactions')) {
      context.handle(
          _transactionsMeta,
          transactions.isAcceptableOrUnknown(
              data['transactions']!, _transactionsMeta));
    } else if (isInserting) {
      context.missing(_transactionsMeta);
    }
    if (data.containsKey('turnover')) {
      context.handle(_turnoverMeta,
          turnover.isAcceptableOrUnknown(data['turnover']!, _turnoverMeta));
    } else if (isInserting) {
      context.missing(_turnoverMeta);
    }
    if (data.containsKey('open_interest')) {
      context.handle(
          _openInterestMeta,
          openInterest.isAcceptableOrUnknown(
              data['open_interest']!, _openInterestMeta));
    } else if (isInserting) {
      context.missing(_openInterestMeta);
    }
    if (data.containsKey('open_interest_value')) {
      context.handle(
          _openInterestValueMeta,
          openInterestValue.isAcceptableOrUnknown(
              data['open_interest_value']!, _openInterestValueMeta));
    } else if (isInserting) {
      context.missing(_openInterestValueMeta);
    }
    if (data.containsKey('nominal_value')) {
      context.handle(
          _nominalValueMeta,
          nominalValue.isAcceptableOrUnknown(
              data['nominal_value']!, _nominalValueMeta));
    } else if (isInserting) {
      context.missing(_nominalValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {stockIsin, date};
  @override
  StockDetailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockDetailData(
      stockIsin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stock_isin'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      openValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}open_value'])!,
      highValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}high_value'])!,
      lowValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}low_value'])!,
      closeValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}close_value'])!,
      change: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}change'])!,
      volume: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volume'])!,
      transactions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}transactions'])!,
      turnover: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}turnover'])!,
      openInterest: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}open_interest'])!,
      openInterestValue: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}open_interest_value'])!,
      nominalValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}nominal_value'])!,
    );
  }

  @override
  $StockDetailTable createAlias(String alias) {
    return $StockDetailTable(attachedDatabase, alias);
  }
}

class StockDetailData extends DataClass implements Insertable<StockDetailData> {
  final String stockIsin;
  final DateTime date;
  final double openValue;
  final double highValue;
  final double lowValue;
  final double closeValue;
  final double change;
  final int volume;
  final int transactions;
  final double turnover;
  final int openInterest;
  final double openInterestValue;
  final double nominalValue;
  const StockDetailData(
      {required this.stockIsin,
      required this.date,
      required this.openValue,
      required this.highValue,
      required this.lowValue,
      required this.closeValue,
      required this.change,
      required this.volume,
      required this.transactions,
      required this.turnover,
      required this.openInterest,
      required this.openInterestValue,
      required this.nominalValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['stock_isin'] = Variable<String>(stockIsin);
    map['date'] = Variable<DateTime>(date);
    map['open_value'] = Variable<double>(openValue);
    map['high_value'] = Variable<double>(highValue);
    map['low_value'] = Variable<double>(lowValue);
    map['close_value'] = Variable<double>(closeValue);
    map['change'] = Variable<double>(change);
    map['volume'] = Variable<int>(volume);
    map['transactions'] = Variable<int>(transactions);
    map['turnover'] = Variable<double>(turnover);
    map['open_interest'] = Variable<int>(openInterest);
    map['open_interest_value'] = Variable<double>(openInterestValue);
    map['nominal_value'] = Variable<double>(nominalValue);
    return map;
  }

  StockDetailCompanion toCompanion(bool nullToAbsent) {
    return StockDetailCompanion(
      stockIsin: Value(stockIsin),
      date: Value(date),
      openValue: Value(openValue),
      highValue: Value(highValue),
      lowValue: Value(lowValue),
      closeValue: Value(closeValue),
      change: Value(change),
      volume: Value(volume),
      transactions: Value(transactions),
      turnover: Value(turnover),
      openInterest: Value(openInterest),
      openInterestValue: Value(openInterestValue),
      nominalValue: Value(nominalValue),
    );
  }

  factory StockDetailData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockDetailData(
      stockIsin: serializer.fromJson<String>(json['stockIsin']),
      date: serializer.fromJson<DateTime>(json['date']),
      openValue: serializer.fromJson<double>(json['openValue']),
      highValue: serializer.fromJson<double>(json['highValue']),
      lowValue: serializer.fromJson<double>(json['lowValue']),
      closeValue: serializer.fromJson<double>(json['closeValue']),
      change: serializer.fromJson<double>(json['change']),
      volume: serializer.fromJson<int>(json['volume']),
      transactions: serializer.fromJson<int>(json['transactions']),
      turnover: serializer.fromJson<double>(json['turnover']),
      openInterest: serializer.fromJson<int>(json['openInterest']),
      openInterestValue: serializer.fromJson<double>(json['openInterestValue']),
      nominalValue: serializer.fromJson<double>(json['nominalValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'stockIsin': serializer.toJson<String>(stockIsin),
      'date': serializer.toJson<DateTime>(date),
      'openValue': serializer.toJson<double>(openValue),
      'highValue': serializer.toJson<double>(highValue),
      'lowValue': serializer.toJson<double>(lowValue),
      'closeValue': serializer.toJson<double>(closeValue),
      'change': serializer.toJson<double>(change),
      'volume': serializer.toJson<int>(volume),
      'transactions': serializer.toJson<int>(transactions),
      'turnover': serializer.toJson<double>(turnover),
      'openInterest': serializer.toJson<int>(openInterest),
      'openInterestValue': serializer.toJson<double>(openInterestValue),
      'nominalValue': serializer.toJson<double>(nominalValue),
    };
  }

  StockDetailData copyWith(
          {String? stockIsin,
          DateTime? date,
          double? openValue,
          double? highValue,
          double? lowValue,
          double? closeValue,
          double? change,
          int? volume,
          int? transactions,
          double? turnover,
          int? openInterest,
          double? openInterestValue,
          double? nominalValue}) =>
      StockDetailData(
        stockIsin: stockIsin ?? this.stockIsin,
        date: date ?? this.date,
        openValue: openValue ?? this.openValue,
        highValue: highValue ?? this.highValue,
        lowValue: lowValue ?? this.lowValue,
        closeValue: closeValue ?? this.closeValue,
        change: change ?? this.change,
        volume: volume ?? this.volume,
        transactions: transactions ?? this.transactions,
        turnover: turnover ?? this.turnover,
        openInterest: openInterest ?? this.openInterest,
        openInterestValue: openInterestValue ?? this.openInterestValue,
        nominalValue: nominalValue ?? this.nominalValue,
      );
  @override
  String toString() {
    return (StringBuffer('StockDetailData(')
          ..write('stockIsin: $stockIsin, ')
          ..write('date: $date, ')
          ..write('openValue: $openValue, ')
          ..write('highValue: $highValue, ')
          ..write('lowValue: $lowValue, ')
          ..write('closeValue: $closeValue, ')
          ..write('change: $change, ')
          ..write('volume: $volume, ')
          ..write('transactions: $transactions, ')
          ..write('turnover: $turnover, ')
          ..write('openInterest: $openInterest, ')
          ..write('openInterestValue: $openInterestValue, ')
          ..write('nominalValue: $nominalValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      stockIsin,
      date,
      openValue,
      highValue,
      lowValue,
      closeValue,
      change,
      volume,
      transactions,
      turnover,
      openInterest,
      openInterestValue,
      nominalValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockDetailData &&
          other.stockIsin == this.stockIsin &&
          other.date == this.date &&
          other.openValue == this.openValue &&
          other.highValue == this.highValue &&
          other.lowValue == this.lowValue &&
          other.closeValue == this.closeValue &&
          other.change == this.change &&
          other.volume == this.volume &&
          other.transactions == this.transactions &&
          other.turnover == this.turnover &&
          other.openInterest == this.openInterest &&
          other.openInterestValue == this.openInterestValue &&
          other.nominalValue == this.nominalValue);
}

class StockDetailCompanion extends UpdateCompanion<StockDetailData> {
  final Value<String> stockIsin;
  final Value<DateTime> date;
  final Value<double> openValue;
  final Value<double> highValue;
  final Value<double> lowValue;
  final Value<double> closeValue;
  final Value<double> change;
  final Value<int> volume;
  final Value<int> transactions;
  final Value<double> turnover;
  final Value<int> openInterest;
  final Value<double> openInterestValue;
  final Value<double> nominalValue;
  const StockDetailCompanion({
    this.stockIsin = const Value.absent(),
    this.date = const Value.absent(),
    this.openValue = const Value.absent(),
    this.highValue = const Value.absent(),
    this.lowValue = const Value.absent(),
    this.closeValue = const Value.absent(),
    this.change = const Value.absent(),
    this.volume = const Value.absent(),
    this.transactions = const Value.absent(),
    this.turnover = const Value.absent(),
    this.openInterest = const Value.absent(),
    this.openInterestValue = const Value.absent(),
    this.nominalValue = const Value.absent(),
  });
  StockDetailCompanion.insert({
    required String stockIsin,
    required DateTime date,
    required double openValue,
    required double highValue,
    required double lowValue,
    required double closeValue,
    required double change,
    required int volume,
    required int transactions,
    required double turnover,
    required int openInterest,
    required double openInterestValue,
    required double nominalValue,
  })  : stockIsin = Value(stockIsin),
        date = Value(date),
        openValue = Value(openValue),
        highValue = Value(highValue),
        lowValue = Value(lowValue),
        closeValue = Value(closeValue),
        change = Value(change),
        volume = Value(volume),
        transactions = Value(transactions),
        turnover = Value(turnover),
        openInterest = Value(openInterest),
        openInterestValue = Value(openInterestValue),
        nominalValue = Value(nominalValue);
  static Insertable<StockDetailData> custom({
    Expression<String>? stockIsin,
    Expression<DateTime>? date,
    Expression<double>? openValue,
    Expression<double>? highValue,
    Expression<double>? lowValue,
    Expression<double>? closeValue,
    Expression<double>? change,
    Expression<int>? volume,
    Expression<int>? transactions,
    Expression<double>? turnover,
    Expression<int>? openInterest,
    Expression<double>? openInterestValue,
    Expression<double>? nominalValue,
  }) {
    return RawValuesInsertable({
      if (stockIsin != null) 'stock_isin': stockIsin,
      if (date != null) 'date': date,
      if (openValue != null) 'open_value': openValue,
      if (highValue != null) 'high_value': highValue,
      if (lowValue != null) 'low_value': lowValue,
      if (closeValue != null) 'close_value': closeValue,
      if (change != null) 'change': change,
      if (volume != null) 'volume': volume,
      if (transactions != null) 'transactions': transactions,
      if (turnover != null) 'turnover': turnover,
      if (openInterest != null) 'open_interest': openInterest,
      if (openInterestValue != null) 'open_interest_value': openInterestValue,
      if (nominalValue != null) 'nominal_value': nominalValue,
    });
  }

  StockDetailCompanion copyWith(
      {Value<String>? stockIsin,
      Value<DateTime>? date,
      Value<double>? openValue,
      Value<double>? highValue,
      Value<double>? lowValue,
      Value<double>? closeValue,
      Value<double>? change,
      Value<int>? volume,
      Value<int>? transactions,
      Value<double>? turnover,
      Value<int>? openInterest,
      Value<double>? openInterestValue,
      Value<double>? nominalValue}) {
    return StockDetailCompanion(
      stockIsin: stockIsin ?? this.stockIsin,
      date: date ?? this.date,
      openValue: openValue ?? this.openValue,
      highValue: highValue ?? this.highValue,
      lowValue: lowValue ?? this.lowValue,
      closeValue: closeValue ?? this.closeValue,
      change: change ?? this.change,
      volume: volume ?? this.volume,
      transactions: transactions ?? this.transactions,
      turnover: turnover ?? this.turnover,
      openInterest: openInterest ?? this.openInterest,
      openInterestValue: openInterestValue ?? this.openInterestValue,
      nominalValue: nominalValue ?? this.nominalValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (stockIsin.present) {
      map['stock_isin'] = Variable<String>(stockIsin.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (openValue.present) {
      map['open_value'] = Variable<double>(openValue.value);
    }
    if (highValue.present) {
      map['high_value'] = Variable<double>(highValue.value);
    }
    if (lowValue.present) {
      map['low_value'] = Variable<double>(lowValue.value);
    }
    if (closeValue.present) {
      map['close_value'] = Variable<double>(closeValue.value);
    }
    if (change.present) {
      map['change'] = Variable<double>(change.value);
    }
    if (volume.present) {
      map['volume'] = Variable<int>(volume.value);
    }
    if (transactions.present) {
      map['transactions'] = Variable<int>(transactions.value);
    }
    if (turnover.present) {
      map['turnover'] = Variable<double>(turnover.value);
    }
    if (openInterest.present) {
      map['open_interest'] = Variable<int>(openInterest.value);
    }
    if (openInterestValue.present) {
      map['open_interest_value'] = Variable<double>(openInterestValue.value);
    }
    if (nominalValue.present) {
      map['nominal_value'] = Variable<double>(nominalValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockDetailCompanion(')
          ..write('stockIsin: $stockIsin, ')
          ..write('date: $date, ')
          ..write('openValue: $openValue, ')
          ..write('highValue: $highValue, ')
          ..write('lowValue: $lowValue, ')
          ..write('closeValue: $closeValue, ')
          ..write('change: $change, ')
          ..write('volume: $volume, ')
          ..write('transactions: $transactions, ')
          ..write('turnover: $turnover, ')
          ..write('openInterest: $openInterest, ')
          ..write('openInterestValue: $openInterestValue, ')
          ..write('nominalValue: $nominalValue')
          ..write(')'))
        .toString();
  }
}

abstract class _$SpgpwDatabase extends GeneratedDatabase {
  _$SpgpwDatabase(QueryExecutor e) : super(e);
  late final $StockTable stock = $StockTable(this);
  late final $StockDetailTable stockDetail = $StockDetailTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [stock, stockDetail];
}
