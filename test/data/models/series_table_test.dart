import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/data/models/series_table.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  group('SeriesTable', () {
    test('fromEntity should return a valid SeriesTable instance', () {
      // Arrange
      const seriesDetail = testSeriesDetail;

      // Act
      final result = SeriesTable.fromEntity(seriesDetail);

      // Assert
      expect(result, isA<SeriesTable>());
      expect(result.id, equals(1));
      expect(result.name, equals("name"));
      expect(result.posterPath, equals("posterPath"));
      expect(result.overview, equals("overview"));
    });

    test('fromMap should return a valid SeriesTable instance', () {
      // Arrange
      final Map<String, dynamic> map = {
        'id': 1,
        'name': "Series Name",
        'posterPath': "/poster.jpg",
        'overview': "Series overview",
      };

      // Act
      final result = SeriesTable.fromMap(map);

      // Assert
      expect(result, isA<SeriesTable>());
      expect(result.id, equals(1));
      expect(result.name, equals("Series Name"));
      expect(result.posterPath, equals("/poster.jpg"));
      expect(result.overview, equals("Series overview"));
    });

    test('toJson should return a valid JSON map', () {
      // Arrange
      const seriesTable = SeriesTable(
        id: 1,
        name: "Series Name",
        posterPath: "/poster.jpg",
        overview: "Series overview",
      );

      // Act
      final result = seriesTable.toJson();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['id'], equals(1));
      expect(result['name'], equals("Series Name"));
      expect(result['posterPath'], equals("/poster.jpg"));
      expect(result['overview'], equals("Series overview"));
    });

    test('toEntity should return a Series entity', () {
      // Arrange
      const seriesTable = SeriesTable(
        id: 1,
        name: "Series Name",
        posterPath: "/poster.jpg",
        overview: "Series overview",
      );

      // Act
      final result = seriesTable.toEntity();

      // Assert
      expect(result, isA<Series>());
      expect(result.id, equals(1));
      expect(result.name, equals("Series Name"));
      expect(result.posterPath, equals("/poster.jpg"));
      expect(result.overview, equals("Series overview"));
    });

    test('props should return correct list of properties', () {
      // Arrange
      const seriesTable1 = SeriesTable(
        id: 1,
        name: "Series Name",
        posterPath: "/poster.jpg",
        overview: "Series overview",
      );
      const seriesTable2 = SeriesTable(
        id: 1,
        name: "Series Name",
        posterPath: "/poster.jpg",
        overview: "Series overview",
      );

      // Act & Assert
      expect(
        seriesTable1.props,
        equals([1, "Series Name", "/poster.jpg", "Series overview"]),
      );
      expect(seriesTable1.props, equals(seriesTable2.props));
    });
  });
}
