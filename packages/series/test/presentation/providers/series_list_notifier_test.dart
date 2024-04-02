import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:series/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/usecases.dart';
import 'package:series/presentation/provider/provider.dart';

import 'series_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnAirSeries, GetPopularSeries, GetTopRatedSeries])
void main() {
  late SeriesListNotifier provider;
  late MockGetOnAirSeries mockGetOnAirSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirSeries = MockGetOnAirSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    provider = SeriesListNotifier(
      getOnAirSeries: mockGetOnAirSeries,
      getPopularSeries: mockGetPopularSeries,
      getTopRatedSeries: mockGetTopRatedSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tSeries = Series(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tSeriesList = <Series>[tSeries];

  group('now playing series', () {
    test('initialState should be Empty', () {
      expect(provider.nowOnAirState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnAirSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchOnAirSeries();
      // assert
      verify(mockGetOnAirSeries.execute());
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetOnAirSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchOnAirSeries();
      // assert
      expect(provider.nowOnAirState, RequestState.loading);
    });

    test('should change series when data is gotten successfully', () async {
      // arrange
      when(mockGetOnAirSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchOnAirSeries();
      // assert
      expect(provider.nowOnAirState, RequestState.loaded);
      expect(provider.nowOnAirSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAirSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAirSeries();
      // assert
      expect(provider.nowOnAirState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.loading);
      // verify(provider.setState(RequestState.loading));
    });

    test('should change series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.loaded);
      expect(provider.popularSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.loading);
    });

    test('should change series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.loaded);
      expect(provider.topRatedSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
