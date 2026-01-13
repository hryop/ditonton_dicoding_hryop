import 'dart:async';

import 'package:core/data/models/watchlist_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static const int databaseVersion = 2;
  static const String CONTENT_TYPE_TV = 'tv';
  static const String CONTENT_TYPE_MOVIE = 'movie';
  static const String CATEGORY_AIRING_TODAY = 'airing today';
  static const String CATEGORY_NOW_PLAYING = 'now playing';

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';
  static const String _tblCache = 'cacahe';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: databaseVersion,
        onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        contentType TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $_tblCache (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT,
        contentType TEXT
      );
    ''');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if(oldVersion < 2){
      await db.execute('''
        ALTER TABLE $_tblWatchlist ADD COLUMN contentType TEXT
      ''');
      await db.execute('''
        ALTER TABLE $_tblCache ADD COLUMN contentType TEXT
      ''');
    }
  }


  Future<int> insertWatchlist(WatchlistModel movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(WatchlistModel movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ? AND contentType = ?',
      whereArgs: [movie.id, movie.contentType],
    );
  }

  Future<Map<String, dynamic>?> getWatchlistItemById(int id, String contentType) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ? AND contentType = ?',
      whereArgs: [id, contentType],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }

  Future<void> insertCacheTransaction(
      List<WatchlistModel> movies, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final movie in movies) {
        final movieJson = movie.toJson();
        movieJson['category'] = category;
        txn.insert(_tblCache, movieJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheMovies(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );
    return results;
  }

  Future<int> clearCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }
}
