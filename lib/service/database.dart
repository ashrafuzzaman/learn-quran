import 'package:logging/logging.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  final log = Logger('DbService');

  withDb(Function(Database db) callback) async {
    var path = 'learn_quran.db';
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute("""
          CREATE TABLE IF NOT EXISTS lessons (
            id INTEGER PRIMARY KEY,
            name varchar(64) UNIQUE,
            description TEXT,
            totalWords INTEGER,
            wordsLearned INTEGER default 0
          );
        """);
        await db.execute("""
          CREATE TABLE IF NOT EXISTS words (
            id INTEGER PRIMARY KEY,
            lessonId INTEGER,
            arabic varchar(64),
            meaning varchar(64),
            plurality varchar(2),
            gender varchar(2),
            learned BOOL default false,
            learnLevel INTEGER default 0,
            read BOOL default false
          );
        """);
        await db.execute("""
          CREATE TABLE IF NOT EXISTS mcq_attempts (
            wordId INTEGER,
            attemptAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            isCorrect BOOL
          );
        """);
        await db.execute("""
          CREATE TABLE IF NOT EXISTS bookmark_words (
            wordId INTEGER UNIQUE
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

  Future<int> update(String table, Map<String, Object?> values,
      {String? where, List<Object?>? whereArgs}) async {
    late int result;
    await withDb((db) async {
      result =
          await db.update(table, values, where: where, whereArgs: whereArgs);
    });
    return result;
  }

  Future<List<Map<String, Object?>>> query(String table,
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
      log.info("Database Initialized...");
    });
  }

  drop() async {
    await withDb((db) async {
      ["lessons", "words", "mcq_attempts", "bookmark_words"]
          .map((table) async => await db.delete(table));
      log.info("Database Cleared!!!");
    });
  }
}
