// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_history.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class HistoryData extends DataClass implements Insertable<HistoryData> {
  final int id;
  final String city;
  final int latitude;
  final int longitude;
  HistoryData(
      {required this.id,
      required this.city,
      required this.latitude,
      required this.longitude});
  factory HistoryData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return HistoryData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      city: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}city'])!,
      latitude: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude'])!,
      longitude: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['city'] = Variable<String>(city);
    map['latitude'] = Variable<int>(latitude);
    map['longitude'] = Variable<int>(longitude);
    return map;
  }

  HistoryCompanion toCompanion(bool nullToAbsent) {
    return HistoryCompanion(
      id: Value(id),
      city: Value(city),
      latitude: Value(latitude),
      longitude: Value(longitude),
    );
  }

  factory HistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return HistoryData(
      id: serializer.fromJson<int>(json['id']),
      city: serializer.fromJson<String>(json['city']),
      latitude: serializer.fromJson<int>(json['latitude']),
      longitude: serializer.fromJson<int>(json['longitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'city': serializer.toJson<String>(city),
      'latitude': serializer.toJson<int>(latitude),
      'longitude': serializer.toJson<int>(longitude),
    };
  }

  HistoryData copyWith(
          {int? id, String? city, int? latitude, int? longitude}) =>
      HistoryData(
        id: id ?? this.id,
        city: city ?? this.city,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );
  @override
  String toString() {
    return (StringBuffer('HistoryData(')
          ..write('id: $id, ')
          ..write('city: $city, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, city, latitude, longitude);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryData &&
          other.id == this.id &&
          other.city == this.city &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude);
}

class HistoryCompanion extends UpdateCompanion<HistoryData> {
  final Value<int> id;
  final Value<String> city;
  final Value<int> latitude;
  final Value<int> longitude;
  const HistoryCompanion({
    this.id = const Value.absent(),
    this.city = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
  });
  HistoryCompanion.insert({
    this.id = const Value.absent(),
    required String city,
    required int latitude,
    required int longitude,
  })  : city = Value(city),
        latitude = Value(latitude),
        longitude = Value(longitude);
  static Insertable<HistoryData> custom({
    Expression<int>? id,
    Expression<String>? city,
    Expression<int>? latitude,
    Expression<int>? longitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (city != null) 'city': city,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    });
  }

  HistoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? city,
      Value<int>? latitude,
      Value<int>? longitude}) {
    return HistoryCompanion(
      id: id ?? this.id,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<int>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<int>(longitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryCompanion(')
          ..write('id: $id, ')
          ..write('city: $city, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude')
          ..write(')'))
        .toString();
  }
}

class $HistoryTable extends History with TableInfo<$HistoryTable, HistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String?> city = GeneratedColumn<String?>(
      'city', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<int?> latitude = GeneratedColumn<int?>(
      'latitude', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<int?> longitude = GeneratedColumn<int?>(
      'longitude', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, city, latitude, longitude];
  @override
  String get aliasedName => _alias ?? 'history';
  @override
  String get actualTableName => 'history';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return HistoryData.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $HistoryTable createAlias(String alias) {
    return $HistoryTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $HistoryTable history = $HistoryTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [history];
}
