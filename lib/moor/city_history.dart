
import 'package:moor_flutter/moor_flutter.dart';
part 'city_history.g.dart';

class History extends Table {

   IntColumn  get id => integer().autoIncrement()();
   TextColumn get city => text()();
   IntColumn  get latitude => integer()();
   IntColumn  get longitude => integer()();

}

@UseMoor(tables: [History])
class AppDatabase extends _$AppDatabase {
   AppDatabase() : super(FlutterQueryExecutor.inDatabaseFolder(
       path: "db.sqlite", logStatements: true));
   int get schemaVersion => 1;

   Future<List<HistoryData>> getHistory() => select(history).get();
   Stream<List<HistoryData>> getAllHistory() => select(history).watch();
   Future insertHistory(HistoryData historyData) => into(history).insert(historyData);
   Future deleteHistory(HistoryData historyData) => delete(history).delete(historyData);
}