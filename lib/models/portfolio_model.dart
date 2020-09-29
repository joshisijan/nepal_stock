import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nepal_stock/api/api_url.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class PortfolioModel extends ChangeNotifier {
  final int portfolioId;
  final String id;
  final String symbol;
  final String name;
  final int quantity;
  final double price;
  final int type;
  final int date;

  PortfolioModel({this.portfolioId, this.id, this.symbol, this.name, this.quantity, this.price, this.type = 0, this.date});

  List<PortfolioModel> _allPortfolio = [];

  // to get total today price
  double _todayPrice = 0.0;

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
      'quantity': quantity,
      'price': price,
      'type': type,
      'date': date,
    };
  }

  insertPortfolio(PortfolioModel portfolio) async {
    try {
      Database db = await dB();
      await db.insert('portfolio', portfolio.toMap());
    } catch (e) {
      print('error from insert portfolio\n' + e.toString());
    }
  }

  deleteAllPortfolio() async {
    try {
      Database db = await dB();
      await db.delete('portfolio');
    } catch (e) {
      print('error from delete all\n' + e.toString());
    }
  }

  deletePortfolio(id) async {
    try {
      Database db = await dB();
      await db.delete('portfolio', where: 'id = $id');
    } catch (e) {
      print('error from delete\n' + e.toString());
    }
  }

  getAllPortfolio() => _allPortfolio;

  setAllPortfolio() async {
    try {
      Database db = await dB();
      final List<Map<String, dynamic>> maps = await db.query('portfolio', orderBy: '-date');
      _allPortfolio = List.generate(maps.length, (i) {
        return PortfolioModel(
          portfolioId: maps[i]['id'],
          id: maps[i]['security_id'],
          symbol: maps[i]['security_symbol'],
          name: maps[i]['security_name'],
          quantity: maps[i]['quantity'],
          price: maps[i]['price'],
          type: maps[i]['type'],
          date: maps[i]['date'],
        );
      });
      setTodayPrice();
    } catch (e) {
      print('error from set all portfolio\n' + e.toString());
    }
  }


  //getter for todayPrice
  getTodayPrice() => _todayPrice;

  //setter for todayPrice
  setTodayPrice() async {
    try{
      // if(_allPortfolio.length > 0){
      //   double _tempPrice = 0.0;
      //   for(int i = 0; i < _allPortfolio.length; i++){
      //     var response = await http.get('$kSecurityDetail/${_allPortfolio[i].id}');
      //     if(response.statusCode == 200){
      //       var jsonData = jsonDecode(response.body);
      //       _tempPrice = _tempPrice + double.parse(jsonData['securityDailyTradeDto']['lastTradedPrice'].toString());
      //     }
      //   }
      //   _todayPrice = _tempPrice;
      // }
      print('haha');
    }catch(e){
      print('error from set today price\n' + e.toString());
    }
  }
}
