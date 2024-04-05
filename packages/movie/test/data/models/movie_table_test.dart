import 'package:flutter_test/flutter_test.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:movie/domain/entities/movie.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('MovieTable', () {
    test('fromEntity should return a valid MovieTable instance', () {
      // Arrange
      const movieDetail = testMovieDetail;

      // Act
      final result = MovieTable.fromEntity(movieDetail);

      // Assert
      expect(result, isA<MovieTable>());
      expect(result.id, equals(1));
      expect(result.title, equals("title"));
      expect(result.posterPath, equals("posterPath"));
      expect(result.overview, equals("overview"));
    });

    test('fromMap should return a valid MovieTable instance', () {
      // Arrange
      final Map<String, dynamic> map = {
        'id': 1,
        'title': "Movie Title",
        'posterPath': "/poster.jpg",
        'overview': "Movie overview",
      };

      // Act
      final result = MovieTable.fromMap(map);

      // Assert
      expect(result, isA<MovieTable>());
      expect(result.id, equals(1));
      expect(result.title, equals("Movie Title"));
      expect(result.posterPath, equals("/poster.jpg"));
      expect(result.overview, equals("Movie overview"));
    });

    test('toJson should return a valid JSON map', () {
      // Arrange
      const movieTable = MovieTable(
        id: 1,
        title: "Movie Title",
        posterPath: "/poster.jpg",
        overview: "Movie overview",
      );

      // Act
      final result = movieTable.toJson();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], equals(1));
      expect(result['title'], equals("Movie Title"));
      expect(result['posterPath'], equals("/poster.jpg"));
      expect(result['overview'], equals("Movie overview"));
    });

    test('toEntity should return a Movie entity', () {
      // Arrange
      const movieTable = MovieTable(
        id: 1,
        title: "Movie Title",
        posterPath: "/poster.jpg",
        overview: "Movie overview",
      );

      // Act
      final result = movieTable.toEntity();

      // Assert
      expect(result, isA<Movie>());
      expect(result.id, equals(1));
      expect(result.title, equals("Movie Title"));
      expect(result.posterPath, equals("/poster.jpg"));
      expect(result.overview, equals("Movie overview"));
    });

    test('props should return correct list of properties', () {
      // Arrange
      const movieTable1 = MovieTable(
        id: 1,
        title: "Movie Title",
        posterPath: "/poster.jpg",
        overview: "Movie overview",
      );
      const movieTable2 = MovieTable(
        id: 1,
        title: "Movie Title",
        posterPath: "/poster.jpg",
        overview: "Movie overview",
      );

      // Act & Assert
      expect(
        movieTable1.props,
        equals([1, "Movie Title", "/poster.jpg", "Movie overview"]),
      );
      expect(movieTable1.props, equals(movieTable2.props));
    });
  });
}
