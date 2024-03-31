import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/series_detail_model.dart';
import 'package:ditonton/domain/entities/series_detail.dart';

void main() {
  group('SeriesDetailModel', () {
    test('fromJson should return a valid model', () {
      // Arrange
      final Map<String, dynamic> json = {
        "adult": false,
        "backdrop_path": "/backdrop.jpg",
        "genres": [
          {"id": 1, "name": "Action"},
          {"id": 2, "name": "Drama"}
        ],
        "homepage": "http://homepage.com",
        "id": 123,
        "imdb_id": "tt1234567",
        "original_language": "en",
        "original_name": "Original Name",
        "overview": "Overview",
        "popularity": 123.45,
        "poster_path": "/poster.jpg",
        "first_air_date": "2022-01-01",
        "status": "Status",
        "tagline": "Tagline",
        "name": "Series Name",
        "vote_average": 7.8,
        "vote_count": 100,
      };

      // Act
      final result = SeriesDetailModel.fromJson(json);

      // Assert
      expect(result, isA<SeriesDetailModel>());
      expect(result.adult, equals(false));
      expect(result.backdropPath, equals("/backdrop.jpg"));
      expect(result.genres.length, equals(2));
      expect(result.homepage, equals("http://homepage.com"));
      expect(result.id, equals(123));
      expect(result.imdbId, equals("tt1234567"));
      expect(result.originalLanguage, equals("en"));
      expect(result.originalName, equals("Original Name"));
      expect(result.overview, equals("Overview"));
      expect(result.popularity, equals(123.45));
      expect(result.posterPath, equals("/poster.jpg"));
      expect(result.firstAirDate, equals("2022-01-01"));
      expect(result.status, equals("Status"));
      expect(result.tagline, equals("Tagline"));
      expect(result.name, equals("Series Name"));
      expect(result.voteAverage, equals(7.8));
      expect(result.voteCount, equals(100));
    });

    test('toJson should return a valid JSON map', () {
      // Arrange
      final model = SeriesDetailModel(
        adult: false,
        backdropPath: "/backdrop.jpg",
        genres: [
          GenreModel(id: 1, name: "Action"),
          GenreModel(id: 2, name: "Drama"),
        ],
        homepage: "http://homepage.com",
        id: 123,
        imdbId: "tt1234567",
        originalLanguage: "en",
        originalName: "Original Name",
        overview: "Overview",
        popularity: 123.45,
        posterPath: "/poster.jpg",
        firstAirDate: "2022-01-01",
        status: "Status",
        tagline: "Tagline",
        name: "Series Name",
        voteAverage: 7.8,
        voteCount: 100,
      );

      // Act
      final result = model.toJson();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result["adult"], equals(false));
      expect(result["backdrop_path"], equals("/backdrop.jpg"));
      expect(result["genres"], isA<List>());
      expect(result["genres"].length, equals(2));
      expect(result["homepage"], equals("http://homepage.com"));
      expect(result["id"], equals(123));
      expect(result["imdb_id"], equals("tt1234567"));
      expect(result["original_language"], equals("en"));
      expect(result["original_name"], equals("Original Name"));
      expect(result["overview"], equals("Overview"));
      expect(result["popularity"], equals(123.45));
      expect(result["poster_path"], equals("/poster.jpg"));
      expect(result["first_air_date"], equals("2022-01-01"));
      expect(result["status"], equals("Status"));
      expect(result["tagline"], equals("Tagline"));
      expect(result["name"], equals("Series Name"));
      expect(result["vote_average"], equals(7.8));
      expect(result["vote_count"], equals(100));
    });

    test('toEntity should return a valid SeriesDetail entity', () {
      // Arrange
      final model = SeriesDetailModel(
        adult: false,
        backdropPath: "/backdrop.jpg",
        genres: [
          GenreModel(id: 1, name: "Action"),
          GenreModel(id: 2, name: "Drama"),
        ],
        homepage: "http://homepage.com",
        id: 123,
        imdbId: "tt1234567",
        originalLanguage: "en",
        originalName: "Original Name",
        overview: "Overview",
        popularity: 123.45,
        posterPath: "/poster.jpg",
        firstAirDate: "2022-01-01",
        status: "Status",
        tagline: "Tagline",
        name: "Series Name",
        voteAverage: 7.8,
        voteCount: 100,
      );

      // Act
      final result = model.toEntity();

      // Assert
      expect(result, isA<SeriesDetail>());
      expect(result.adult, equals(false));
      expect(result.backdropPath, equals("/backdrop.jpg"));
      expect(result.genres.length, equals(2));
      expect(result.id, equals(123));
      expect(result.originalName, equals("Original Name"));
      expect(result.overview, equals("Overview"));
      expect(result.posterPath, equals("/poster.jpg"));
      expect(result.firstAirDate, equals("2022-01-01"));
      expect(result.name, equals("Series Name"));
      expect(result.voteAverage, equals(7.8));
      expect(result.voteCount, equals(100));
    });

    test('props should return correct list of properties', () {
      // Arrange
      final model1 = SeriesDetailModel(
        adult: false,
        backdropPath: "/backdrop.jpg",
        genres: [
          GenreModel(id: 1, name: "Action"),
          GenreModel(id: 2, name: "Drama"),
        ],
        homepage: "http://homepage.com",
        id: 123,
        imdbId: "tt1234567",
        originalLanguage: "en",
        originalName: "Original Name",
        overview: "Overview",
        popularity: 123.45,
        posterPath: "/poster.jpg",
        firstAirDate: "2022-01-01",
        status: "Status",
        tagline: "Tagline",
        name: "Series Name",
        voteAverage: 7.8,
        voteCount: 100,
      );
      final model2 = SeriesDetailModel(
        adult: false,
        backdropPath: "/backdrop.jpg",
        genres: [
          GenreModel(id: 1, name: "Action"),
          GenreModel(id: 2, name: "Drama"),
        ],
        homepage: "http://homepage.com",
        id: 123,
        imdbId: "tt1234567",
        originalLanguage: "en",
        originalName: "Original Name",
        overview: "Overview",
        popularity: 123.45,
        posterPath: "/poster.jpg",
        firstAirDate: "2022-01-01",
        status: "Status",
        tagline: "Tagline",
        name: "Series Name",
        voteAverage: 7.8,
        voteCount: 100,
      );

      // Act & Assert
      expect(model1.props, equals(model2.props));
    });
  });
}
