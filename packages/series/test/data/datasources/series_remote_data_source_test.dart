import 'dart:convert';

import 'package:core/common/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:series/data/datasources/series_remote_data_source.dart';
import 'package:series/data/models/series_detail_model.dart';
import 'package:series/data/models/series_response.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late SeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = SeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On Air Series', () {
    final tSeriesList =
        SeriesResponse.fromJson(json.decode(readJson('dummy_data/on_air.json')))
            .seriesList;

    test('should return list of Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/on_air.json'), 200));
      // act
      final result = await dataSource.getOnAirSeries();
      // assert
      expect(result, equals(tSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnAirSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Series', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/popular_series.json')))
        .seriesList;

    test('should return list of series when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_series.json'), 200));
      // act
      final result = await dataSource.getPopularSeries();
      // assert
      expect(result, tSeriesList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Series', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_series.json')))
        .seriesList;

    test('should return list of series when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/top_rated_series.json'), 200));
      // act
      final result = await dataSource.getTopRatedSeries();
      // assert
      expect(result, tSeriesList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    const tId = 1;
    final tMovieDetail = SeriesDetailModel.fromJson(
        json.decode(readJson('dummy_data/series_detail.json')));

    test('should return series detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/series_detail.json'), 200));
      // act
      final result = await dataSource.getSeriesDetail(tId);
      // assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get series recommendations', () {
    final tSeriesList = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/series_recommendations.json')))
        .seriesList;
    const tId = 1;

    test('should return list of Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/series_recommendations.json'), 200));
      // act
      final result = await dataSource.getSeriesRecommendations(tId);
      // assert
      expect(result, equals(tSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = SeriesResponse.fromJson(
            json.decode(readJson('dummy_data/search_breaking_bad_series.json')))
        .seriesList;
    const tQuery = 'Breaking Bad';

    test('should return list of series when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_breaking_bad_series.json'), 200));
      // act
      final result = await dataSource.searchSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
