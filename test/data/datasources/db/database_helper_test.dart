import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/series_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import 'database_helper_test.mocks.dart';

@GenerateMocks([Database])
void main() {
  late MockDatabase mockDatabase;
  late DatabaseHelper databaseHelper;

  setUp(() {
    mockDatabase = MockDatabase();
    databaseHelper = DatabaseHelper(database: mockDatabase);
  });

  group('Insert Watchlist', () {
    test('insertWatchlist should return id of inserted movie', () async {
      // Arrange
      const movie = MovieTable(
          id: 1,
          title: 'Movie 1',
          overview: 'Overview 1',
          posterPath: 'poster.jpg');
      when(mockDatabase.insert(any, any)).thenAnswer((_) async => 1);

      // Act
      final result = await databaseHelper.insertWatchlist(movie);

      // Assert
      expect(result, 1);
    });

    test('insertSeriesWatchlist should return id of inserted series', () async {
      // Arrange
      const series = SeriesTable(
          id: 1,
          name: 'Series 1',
          overview: 'Overview 1',
          posterPath: 'poster.jpg');
      when(mockDatabase.insert(any, any)).thenAnswer((_) async => 1);

      // Act
      final result = await databaseHelper.insertSeriesWatchlist(series);

      // Assert
      expect(result, 1);
    });
  });

  group('Remove Watchlist', () {
    test('removeWatchlist should return the number of deleted records',
        () async {
      // Arrange
      const movie = MovieTable(
          id: 1,
          title: 'Movie 1',
          overview: 'Overview 1',
          posterPath: 'poster.jpg');
      when(mockDatabase.delete(any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      // Act
      final result = await databaseHelper.removeWatchlist(movie);

      // Assert
      expect(result, 1);
    });

    test('removeSeriesWatchlist should return the number of deleted records',
        () async {
      // Arrange
      const series = SeriesTable(
          id: 1,
          name: 'Series 1',
          overview: 'Overview 1',
          posterPath: 'poster.jpg');

      when(mockDatabase.delete(any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => 1);

      // Act
      final result = await databaseHelper.removeSeriesWatchlist(series);

      // Assert
      expect(result, 1);
    });
  });

  group('Get Movie/Series by ID', () {
    test('getMovieById should return movie map if exists', () async {
      // Arrange
      const movieId = 1;
      final movieMap = {
        'id': 1,
        'title': 'Movie 1',
        'overview': 'Overview 1',
        'posterPath': 'poster.jpg'
      };
      when(mockDatabase.query(any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => [movieMap]);

      // Act
      final result = await databaseHelper.getMovieById(movieId);

      // Assert
      expect(result, movieMap);
    });

    test('getMovieById should return null if movie does not exist', () async {
      // Arrange
      const movieId = 1;
      when(mockDatabase.query(any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => []);

      // Act
      final result = await databaseHelper.getMovieById(movieId);

      // Assert
      expect(result, null);
    });

    test('getSeriesById should return series map if exists', () async {
      // Arrange
      const seriesId = 1;
      final seriesMap = {
        'id': 1,
        'name': 'Series 1',
        'overview': 'Overview 1',
        'posterPath': 'poster.jpg'
      };
      when(mockDatabase.query(any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => [seriesMap]);

      // Act
      final result = await databaseHelper.getSeriesById(seriesId);

      // Assert
      expect(result, seriesMap);
    });

    test('getSeriesById should return null if series does not exist', () async {
      // Arrange
      const seriesId = 1;
      when(mockDatabase.query(any,
              where: anyNamed('where'), whereArgs: anyNamed('whereArgs')))
          .thenAnswer((_) async => []);

      // Act
      final result = await databaseHelper.getSeriesById(seriesId);

      // Assert
      expect(result, null);
    });
  });

  group('Get Watchlist Movies/Series', () {
    test('getWatchlistMovies should return list of movie maps', () async {
      // Arrange
      final movieMaps = [
        {
          'id': 1,
          'title': 'Movie 1',
          'overview': 'Overview 1',
          'posterPath': 'poster.jpg'
        },
        {
          'id': 2,
          'title': 'Movie 2',
          'overview': 'Overview 2',
          'posterPath': 'poster.jpg'
        }
      ];
      when(mockDatabase.query(any)).thenAnswer((_) async => movieMaps);

      // Act
      final result = await databaseHelper.getWatchlistMovies();

      // Assert
      expect(result, movieMaps);
    });

    test('getWatchlistSeries should return list of series maps', () async {
      // Arrange
      final seriesMaps = [
        {
          'id': 1,
          'name': 'Series 1',
          'overview': 'Overview 1',
          'posterPath': 'poster.jpg'
        },
        {
          'id': 2,
          'name': 'Series 2',
          'overview': 'Overview 2',
          'posterPath': 'poster.jpg'
        }
      ];
      when(mockDatabase.query(any)).thenAnswer((_) async => seriesMaps);

      // Act
      final result = await databaseHelper.getWatchlistSeries();

      // Assert
      expect(result, seriesMaps);
    });
  });
}
