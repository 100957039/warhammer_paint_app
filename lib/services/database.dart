import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openMyDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'my_database.db');
  final database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      // Create tables here
    },
  );
  return database;
}