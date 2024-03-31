import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SeasonModel', () {
    test('fromJson should return a valid model', () {
      final Map<String, dynamic> jsonMap = {
        "air_date": "2022-01-01",
        "episode_count": 10,
        "id": 1,
        "name": "Season 1",
        "overview": "Season 1 overview",
        "poster_path": "/path/to/poster.jpg",
        "season_number": 1,
        "vote_average": 8.5,
      };

      final result = SeasonModel.fromJson(jsonMap);

      expect(result, isA<SeasonModel>());
      expect(result.airDate, '2022-01-01');
      expect(result.episodeCount, 10);
      expect(result.id, 1);
      expect(result.name, 'Season 1');
      expect(result.overview, 'Season 1 overview');
      expect(result.posterPath, '/path/to/poster.jpg');
      expect(result.seasonNumber, 1);
      expect(result.voteAverage, 8.5);
    });

    test('toJson should return a valid JSON map', () {
      const seasonModel = SeasonModel(
        airDate: '2022-01-01',
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'Season 1 overview',
        posterPath: '/path/to/poster.jpg',
        seasonNumber: 1,
        voteAverage: 8.5,
      );

      final result = seasonModel.toJson();

      expect(result['air_date'], '2022-01-01');
      expect(result['episode_count'], 10);
      expect(result['id'], 1);
      expect(result['name'], 'Season 1');
      expect(result['overview'], 'Season 1 overview');
      expect(result['poster_path'], '/path/to/poster.jpg');
      expect(result['season_number'], 1);
      expect(result['vote_average'], 8.5);
    });

    test('toEntity should return a valid Season entity', () {
      const seasonModel = SeasonModel(
        airDate: '2022-01-01',
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'Season 1 overview',
        posterPath: '/path/to/poster.jpg',
        seasonNumber: 1,
        voteAverage: 8.5,
      );

      final result = seasonModel.toEntity();

      expect(result, isA<Season>());
      expect(result.airDate, '2022-01-01');
      expect(result.episodeCount, 10);
      expect(result.id, 1);
      expect(result.name, 'Season 1');
      expect(result.overview, 'Season 1 overview');
      expect(result.posterPath, '/path/to/poster.jpg');
      expect(result.seasonNumber, 1);
      expect(result.voteAverage, 8.5);
    });

    test('season entity shoukd be compareable', () {
      const seasonModel1 = SeasonModel(
        airDate: '2022-01-01',
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'Season 1 overview',
        posterPath: '/path/to/poster.jpg',
        seasonNumber: 1,
        voteAverage: 8.5,
      );

      const seasonModel2 = SeasonModel(
        airDate: '2022-01-01',
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'Season 1 overview',
        posterPath: '/path/to/poster.jpg',
        seasonNumber: 1,
        voteAverage: 8.5,
      );

      final season1 = seasonModel1.toEntity();
      final season2 = seasonModel2.toEntity();

      expect(season1.props, season2.props);
    });

    test('get props should return list of properties', () {
      const seasonModel1 = SeasonModel(
        airDate: '2022-01-01',
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'Season 1 overview',
        posterPath: '/path/to/poster.jpg',
        seasonNumber: 1,
        voteAverage: 8.5,
      );

      const seasonModel2 = SeasonModel(
        airDate: '2022-01-01',
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'Season 1 overview',
        posterPath: '/path/to/poster.jpg',
        seasonNumber: 1,
        voteAverage: 8.5,
      );

      expect(seasonModel1.props, seasonModel2.props);
    });
  });
}
