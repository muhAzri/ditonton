import 'dart:async';

import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/series_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';
  static const String _tblSeriesWatchList = 'series_watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE  $_tblWatchlist (
      id INTEGER PRIMARY KEY,
      title TEXT,
      overview TEXT,
      posterPath TEXT
    );
    ''');

    await db.execute('''
    CREATE TABLE  $_tblSeriesWatchList (
          id INTEGER PRIMARY KEY,
          name TEXT,
          overview TEXT,
          posterPath TEXT
        );
    ''');
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> insertSeriesWatchlist(SeriesTable series) async {
    final db = await database;
    return await db!.insert(_tblSeriesWatchList, series.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> removeSeriesWatchlist(SeriesTable series) async {
    final db = await database;
    return await db!.delete(
      _tblSeriesWatchList,
      where: 'id = ?',
      whereArgs: [series.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblSeriesWatchList,
      where: 'id = ?',
      whereArgs: [id],
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

  Future<List<Map<String, dynamic>>> getWatchlistSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblSeriesWatchList);

    return results;
  }
}
