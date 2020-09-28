import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class PortfolioModel extends ChangeNotifier {
  final int portfolioId;
  final String id;
  final String symbol;
  final String name;
  final int quantity;
  final double price;

  PortfolioModel({this.portfolioId, this.id, this.symbol, this.name, this.quantity, this.price});

  List<PortfolioModel> _allPortfolio;

  Database _db;
  bool isInitialized = false;

  _createTables(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE portfolio(id INTEGER PRIMARY KEY, security_id VARCHAR(100), security_symbol VARCHAR(100), security_name VARCHAR(100), quantity INTEGER, price REAL)');
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
      'quantity': quantity,
      'price': price,
    };
  }

  insertPortfolio(PortfolioModel portfolio) async {
    try {
      Database db = await dB();
      await db.insert('portfolio', portfolio.toMap());
      notifyListeners();
    } catch (e) {
      print('error from insert portfolio\n' + e.toString());
    }
  }

  deleteAllPortfolio() async {
    try {
      Database db = await dB();
      await db.delete('portfolio');
      notifyListeners();
    } catch (e) {
      print('error from delete all\n' + e.toString());
    }
  }

  deletePortfolio(id) async {
    try {
      Database db = await dB();
      await db.delete('portfolio', where: 'id = $id');
      notifyListeners();
    } catch (e) {
      print('error from delete\n' + e.toString());
    }
  }

  getAllPortfolio() => _allPortfolio;

  setAllPortfolio() async {
    try {
      Database db = await dB();
      final List<Map<String, dynamic>> maps = await db.query('portfolio', orderBy: '-id');
      _allPortfolio = List.generate(maps.length, (i) {
        return PortfolioModel(
          portfolioId: maps[i]['id'],
          id: maps[i]['security_id'],
          symbol: maps[i]['security_symbol'],
          name: maps[i]['security_name'],
          quantity: maps[i]['quantity'],
          price: maps[i]['price'],
        );
      });
      notifyListeners();
    } catch (e) {
      print('error from set all portfolio\n' + e.toString());
    }
  }
}
