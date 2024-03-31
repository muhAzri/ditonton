import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GenreModel', () {
    test('fromJson should return a valid model', () {
      // Arrange
      final Map<String, dynamic> json = {
        "id": 1,
        "name": "Action",
      };

      // Act
      final result = GenreModel.fromJson(json);

      // Assert
      expect(result, isA<GenreModel>());
      expect(result.id, equals(1));
      expect(result.name, equals("Action"));
    });

    test('toJson should return a valid JSON map', () {
      // Arrange
      final genreModel = GenreModel(id: 1, name: "Action");

      // Act
      final result = genreModel.toJson();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result["id"], equals(1));
      expect(result["name"], equals("Action"));
    });

    test('toEntity should return a Genre entity', () {
      // Arrange
      final genreModel = GenreModel(id: 1, name: "Action");

      // Act
      final result = genreModel.toEntity();

      // Assert
      expect(result, isA<Genre>());
      expect(result.id, equals(1));
      expect(result.name, equals("Action"));
    });

    test('props should return correct list of properties', () {
      // Arrange
      final genreModel1 = GenreModel(id: 1, name: "Action");
      final genreModel2 = GenreModel(id: 1, name: "Action");

      // Act & Assert
      expect(genreModel1.props, equals([1, "Action"]));
      expect(genreModel1.props, equals(genreModel2.props));
    });
  });
}
