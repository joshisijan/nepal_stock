import 'package:nepal_stock/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WatchlistRepo {
  static final WatchlistRepo watchlistRepo = WatchlistRepo._();

  factory WatchlistRepo.instance() {
    return watchlistRepo;
  }

  WatchlistRepo._();

  Future<Database> openDb() async {
    Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'nepal_stock.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE watchlist(id INTEGER PRIMARY KEY, symbol VARCHAR(100), value VARCHAR(100))");
      },
      version: 1,
    );
    return database;
  }

  insertSymbol(SymbolModel symbol) async {
    Database database = await openDb();
    database.insert(
      'watchlist',
      symbol.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SymbolModel>> getSymbols() async {
    Database database = await openDb();
    final List<Map<String, dynamic>> maps =
        await database.query('watchlist', orderBy: '-id');
    return List.generate(maps.length, (i) {
      return SymbolModel(
        id: maps[i]['id'],
        symbol: maps[i]['symbol'],
        value: maps[i]['value'],
      );
    });
  }

  deleteAll() async {
    Database database = await openDb();
    database.delete('watchlist');
  }

  deleteSymbol(String id) async {
    Database database = await openDb();
    database.delete('watchlist', where: '"id" = $id');
  }
}
