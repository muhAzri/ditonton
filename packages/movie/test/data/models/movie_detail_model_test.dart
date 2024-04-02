import 'package:core/data/model/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_detail_model.dart';
import 'package:movie/domain/entities/movie_detail.dart';

void main() {
  group('MovieDetailResponse', () {
    test('fromJson should return a valid model', () {
      // Arrange
      final Map<String, dynamic> json = {
        "adult": false,
        "backdrop_path": "/backdrop.jpg",
        "budget": 10000000,
        "genres": [
          {"id": 1, "name": "Action"},
          {"id": 2, "name": "Drama"}
        ],
        "homepage": "http://homepage.com",
        "id": 123,
        "imdb_id": "tt1234567",
        "original_language": "en",
        "original_title": "Original Title",
        "overview": "Overview",
        "popularity": 123.45,
        "poster_path": "/poster.jpg",
        "release_date": "2022-01-01",
        "revenue": 1000000,
        "runtime": 120,
        "status": "Status",
        "tagline": "Tagline",
        "title": "Movie Title",
        "video": false,
        "vote_average": 7.8,
        "vote_count": 100,
      };

      // Act
      final result = MovieDetailResponse.fromJson(json);

      // Assert
      expect(result, isA<MovieDetailResponse>());
      expect(result.adult, equals(false));
      expect(result.backdropPath, equals("/backdrop.jpg"));
      expect(result.budget, equals(10000000));
      expect(result.genres.length, equals(2));
      expect(result.homepage, equals("http://homepage.com"));
      expect(result.id, equals(123));
      expect(result.imdbId, equals("tt1234567"));
      expect(result.originalLanguage, equals("en"));
      expect(result.originalTitle, equals("Original Title"));
      expect(result.overview, equals("Overview"));
      expect(result.popularity, equals(123.45));
      expect(result.posterPath, equals("/poster.jpg"));
      expect(result.releaseDate, equals("2022-01-01"));
      expect(result.revenue, equals(1000000));
      expect(result.runtime, equals(120));
      expect(result.status, equals("Status"));
      expect(result.tagline, equals("Tagline"));
      expect(result.title, equals("Movie Title"));
      expect(result.video, equals(false));
      expect(result.voteAverage, equals(7.8));
      expect(result.voteCount, equals(100));
    });

    test('toJson should return a valid JSON map', () {
      // Arrange
      const model = MovieDetailResponse(
        adult: false,
        backdropPath: "/backdrop.jpg",
        budget: 10000000,
        genres: [
          GenreModel(id: 1, name: "Action"),
          GenreModel(id: 2, name: "Drama"),
        ],
        homepage: "http://homepage.com",
        id: 123,
        imdbId: "tt1234567",
        originalLanguage: "en",
        originalTitle: "Original Title",
        overview: "Overview",
        popularity: 123.45,
        posterPath: "/poster.jpg",
        releaseDate: "2022-01-01",
        revenue: 1000000,
        runtime: 120,
        status: "Status",
        tagline: "Tagline",
        title: "Movie Title",
        video: false,
        voteAverage: 7.8,
        voteCount: 100,
      );

      // Act
      final result = model.toJson();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result["adult"], equals(false));
      expect(result["backdrop_path"], equals("/backdrop.jpg"));
      expect(result["budget"], equals(10000000));
      expect(result["genres"], isA<List>());
      expect(result["genres"].length, equals(2));
      expect(result["homepage"], equals("http://homepage.com"));
      expect(result["id"], equals(123));
      expect(result["imdb_id"], equals("tt1234567"));
      expect(result["original_language"], equals("en"));
      expect(result["original_title"], equals("Original Title"));
      expect(result["overview"], equals("Overview"));
      expect(result["popularity"], equals(123.45));
      expect(result["poster_path"], equals("/poster.jpg"));
      expect(result["release_date"], equals("2022-01-01"));
      expect(result["revenue"], equals(1000000));
      expect(result["runtime"], equals(120));
      expect(result["status"], equals("Status"));
      expect(result["tagline"], equals("Tagline"));
      expect(result["title"], equals("Movie Title"));
      expect(result["video"], equals(false));
      expect(result["vote_average"], equals(7.8));
      expect(result["vote_count"], equals(100));
    });

    test('toEntity should return a valid MovieDetail entity', () {
      // Arrange
      const model = MovieDetailResponse(
        adult: false,
        backdropPath: "/backdrop.jpg",
        budget: 10000000,
        genres: [
          GenreModel(id: 1, name: "Action"),
          GenreModel(id: 2, name: "Drama"),
        ],
        homepage: "http://homepage.com",
        id: 123,
        imdbId: "tt1234567",
        originalLanguage: "en",
        originalTitle: "Original Title",
        overview: "Overview",
        popularity: 123.45,
        posterPath: "/poster.jpg",
        releaseDate: "2022-01-01",
        revenue: 1000000,
        runtime: 120,
        status: "Status",
        tagline: "Tagline",
        title: "Movie Title",
        video: false,
        voteAverage: 7.8,
        voteCount: 100,
      );

      // Act
      final result = model.toEntity();

      // Assert
      expect(result, isA<MovieDetail>());
      expect(result.adult, equals(false));
      expect(result.backdropPath, equals("/backdrop.jpg"));
      expect(result.genres.length, equals(2));
      expect(result.id, equals(123));
      expect(result.originalTitle, equals("Original Title"));
      expect(result.overview, equals("Overview"));
      expect(result.posterPath, equals("/poster.jpg"));
      expect(result.releaseDate, equals("2022-01-01"));
      expect(result.runtime, equals(120));
      expect(result.title, equals("Movie Title"));
      expect(result.voteAverage, equals(7.8));
      expect(result.voteCount, equals(100));
    });

    test('props should return correct list of properties', () {
      // Arrange
      const model1 = MovieDetailResponse(
        adult: false,
        backdropPath: "/backdrop.jpg",
        budget: 10000000,
        genres: [
          GenreModel(id: 1, name: "Action"),
          GenreModel(id: 2, name: "Drama"),
        ],
        homepage: "http://homepage.com",
        id: 123,
        imdbId: "tt1234567",
        originalLanguage: "en",
        originalTitle: "Original Title",
        overview: "Overview",
        popularity: 123.45,
        posterPath: "/poster.jpg",
        releaseDate: "2022-01-01",
        revenue: 1000000,
        runtime: 120,
        status: "Status",
        tagline: "Tagline",
        title: "Movie Title",
        video: false,
        voteAverage: 7.8,
        voteCount: 100,
      );
      const model2 = MovieDetailResponse(
        adult: false,
        backdropPath: "/backdrop.jpg",
        budget: 10000000,
        genres: [
          GenreModel(id: 1, name: "Action"),
          GenreModel(id: 2, name: "Drama"),
        ],
        homepage: "http://homepage.com",
        id: 123,
        imdbId: "tt1234567",
        originalLanguage: "en",
        originalTitle: "Original Title",
        overview: "Overview",
        popularity: 123.45,
        posterPath: "/poster.jpg",
        releaseDate: "2022-01-01",
        revenue: 1000000,
        runtime: 120,
        status: "Status",
        tagline: "Tagline",
        title: "Movie Title",
        video: false,
        voteAverage: 7.8,
        voteCount: 100,
      );

      // Act & Assert
      expect(model1.props, equals(model2.props));
    });
  });
}
