import 'package:logging/logging.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  withDb(Function(Database db) callback) async {
    var path = 'learn_quran.db';
    // Database db = await openDatabase('learn_quran.db');
    Database db = await openDatabase(
      path,
      version: 3,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute("""
          CREATE TABLE IF NOT EXISTS quiz_attempt (
            wordId varchar(36),
            attemptAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            isCorrect BOOL
          );
        """);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("""
          CREATE TABLE IF NOT EXISTS bookmark_word (
            wordId varchar(36) UNIQUE
          );
        """);
      },
    );

    await callback(db);
    await db.close();
  }

  Future<int> insert(String table, Map<String, Object?> values,
      {String? nullColumnHack, ConflictAlgorithm? conflictAlgorithm}) async {
    late int result;
    await withDb((db) async {
      result = await db.insert(table, values);
    });
    return result;
  }

  Future<int> delete(String table,
      {String? where, List<Object?>? whereArgs}) async {
    late int result;
    await withDb((db) async {
      result = await db.delete(table, where: where, whereArgs: whereArgs);
    });
    return result;
  }

  query(String table,
      {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset}) async {
    late List<Map<String, Object?>> result;

    await withDb((db) async {
      result = await db.query(
        table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
      );
    });
    return result;
  }

  initiate() async {
    await withDb((db) async {
      final log = Logger('DbService');
      // db.execute("drop table quiz_attempt");
      log.info("Database Initialized...");
    });
  }
}
