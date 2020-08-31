import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Symbol {
  final int id;
  final String symbol;
  final String value;

  Symbol._({this.id, this.symbol, this.value}) {
    openDb();
  }
  static final Symbol db = Symbol._();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'value': value,
    };
  }

  static Future<Database> openDb() async {
    Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'database.db'), onCreate: (db, version) {
          return db.execute(
          'CREATE TABLE Symbol(id INTEGER PRIMARY KEY, symbol VARCHAR(100), value VARCHAR(100))');
    }, version: 1);
    return database;
  }

  static insertSymbol(Symbol symbol) async {
    Future<Database> database = openDb();
    final Database db = await database;
    await db.insert(
      'Symbol',
      symbol.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db.close();
  }

  static Future<List<Symbol>> getSymbol() async {
    Future<Database> database = openDb();
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Symbol');
    
    return List.generate(maps.length, (index){
      return Symbol(
        id: maps[index]['id'],
        symbol: maps[index]['symbol'],
        value: maps[index]['value']
      );
    });
  }

  static deleteAllSymbol() async {
    Future<Database> database = openDb();
    final Database db = await database;
    db.delete('Symbol');
  }
}
