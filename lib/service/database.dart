import 'package:flutter/material.dart';
import 'package:learnquran/service/database_initializer.dart';
import 'package:logging/logging.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  withDb(Function(Database db) callback) async {
    var path = 'learn_quran.db';
    Database db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute("""
          CREATE TABLE IF NOT EXISTS lessons (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name varchar(64) UNIQUE,
            description TEXT,
            totalWords INTEGER,
            wordsLearned INTEGER default 0
          );
        """);
        await db.execute("""
          CREATE TABLE IF NOT EXISTS words (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
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
            wordId varchar(36),
            attemptAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            isCorrect BOOL
          );
        """);
        await db.execute("""
          CREATE TABLE IF NOT EXISTS bookmark_words (
            wordId varchar(36) UNIQUE
          );
        """);
        await db.execute("""
          CREATE TABLE IF NOT EXISTS progression (
            wordId varchar(36) UNIQUE,
            createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
          );
        """);
        // await initializeWordsDatabase(const Locale('en'));
      },
      // onUpgrade: (db, oldVersion, newVersion) async {
      //   await initializeWordsDatabase(const Locale('en'));
      // },
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
      final log = Logger('DbService');
      log.info("Database Initialized...");
    });
  }
}
