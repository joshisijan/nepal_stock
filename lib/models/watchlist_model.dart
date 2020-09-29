import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class WatchlistModel extends ChangeNotifier {
  final String id;
  final String symbol;
  final String name;

  WatchlistModel({this.id, this.symbol, this.name});

  List<WatchlistModel> _allWatchlist;

  Database _db;
  bool isInitialized = false;

  _createTables(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE portfolio(id INTEGER PRIMARY KEY, security_id VARCHAR(100), security_symbol VARCHAR(100), security_name VARCHAR(100), quantity INTEGER, price REAL, type INTEGER, date INTEGER)');
    await db.execute(
        'CREATE TABLE watchlist(id INTEGER PRIMARY KEY, security_id VARCHAR(100), security_symbol VARCHAR(100), security_name VARCHAR(100))');
  }

  _openDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    _db =  await openDatabase(
      path.join(await getDatabasesPath(), 'nepal_stock.db'),
      onCreate: (db, version) {
        return _createTables(db, version);
      },
      version: 1,
    ).whenComplete(() => isInitialized = true);
  }

  Future<Database> dB() async {
    if(!isInitialized) await _openDatabase();
    return _db;
  }
  

  Map<String, dynamic> toMap() {
    return {
      'security_id': id,
      'security_symbol': symbol,
      'security_name': name,
    };
  }

  insertWatchlist(WatchlistModel watchlist) async {
    try {
      Database db = await dB();
      var row = await db.query('watchlist', where: 'security_id = ${watchlist.id}');
      if(row.length <= 0){
        await db.insert('watchlist', watchlist.toMap());
        notifyListeners();
      }
    } catch (e) {
      print('error from insert watchlist\n' + e.toString());
    }
  }

  Future<bool> checkExists(id) async {
    try {
      Database db = await dB();
      var row = await db.query('watchlist', where: 'security_id = ${id.toString()}');
      if(row.length <= 0){
        return false;
      }
      else{
        return true;
      }
    } catch (e) {
      print('error from insert watchlist\n' + e.toString());
    }
    return false;
  }

  deleteAllWatchlist() async {
    try {
      Database db = await dB();
      await db.delete('watchlist');
      notifyListeners();
    } catch (e) {
      print('error from delete all\n' + e.toString());
    }
  }

  deleteWatchlist(id) async {
    try {
      Database db = await dB();
      await db.delete('watchlist', where: 'security_id = $id');
      notifyListeners();
    } catch (e) {
      print('error from delete all\n' + e.toString());
    }
  }

  getAllWatchlist() => _allWatchlist;

  setAllWatchlist() async {
    try {
      Database db = await dB();
      final List<Map<String, dynamic>> maps =
          await db.query('watchlist', orderBy: '-id');
      _allWatchlist = List.generate(maps.length, (i) {
        return WatchlistModel(
          id: maps[i]['security_id'],
          symbol: maps[i]['security_symbol'],
          name: maps[i]['security_name'],
        );
      });
      notifyListeners();
    } catch (e) {
      print('error from set all watchlist\n' + e.toString());
    }
  }
}
