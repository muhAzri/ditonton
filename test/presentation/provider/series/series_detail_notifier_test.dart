import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_series_detail.dart';
import 'package:ditonton/domain/usecases/get_series_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_series_status.dart';
import 'package:ditonton/domain/usecases/remove_series_watchlist.dart';
import 'package:ditonton/domain/usecases/save_series_watchlist.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/series/series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetSeriesRecommendations,
  GetWatchListSeriesStatus,
  SaveSeriesWatchlist,
  RemoveSeriesWatchlist,
])
void main() {
  late SeriesDetailNotifier provider;
  late MockGetSeriesDetail mockSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetWatchListSeriesStatus getWatchListSeriesStatus;
  late MockSaveSeriesWatchlist mockSaveSeriesWatchlist;
  late MockRemoveSeriesWatchlist mockRemoveSeriesWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    getWatchListSeriesStatus = MockGetWatchListSeriesStatus();
    mockSaveSeriesWatchlist = MockSaveSeriesWatchlist();
    mockRemoveSeriesWatchlist = MockRemoveSeriesWatchlist();
    provider = SeriesDetailNotifier(
      getSeriesDetail: mockSeriesDetail,
      getSeriesRecommendations: mockGetSeriesRecommendations,
      getWatchListSeriesStatus: getWatchListSeriesStatus,
      saveSeriesWatchlist: mockSaveSeriesWatchlist,
      removeSeriesWatchlist: mockRemoveSeriesWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  const tId = 1;

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

  void arrangeUsecase() {
    when(mockSeriesDetail.execute(tId))
        .thenAnswer((_) async => const Right(testSeriesDetail));
    when(mockGetSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tSeriesList));
  }

  group('Get Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      verify(mockSeriesDetail.execute(tId));
      verify(mockGetSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      arrangeUsecase();
      // act
      provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.series, testSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Loaded);
      expect(provider.seriesRecommendation, tSeriesList);
    });
  });

  group('Get Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      verify(mockGetSeriesRecommendations.execute(tId));
      expect(provider.seriesRecommendation, tSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      arrangeUsecase();
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.seriesRecommendation, tSeriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Right(testSeriesDetail));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Failed')));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(getWatchListSeriesStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveSeriesWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Success'));
      when(getWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(mockSaveSeriesWatchlist.execute(testSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveSeriesWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Removed'));
      when(getWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testSeriesDetail);
      // assert
      verify(mockRemoveSeriesWatchlist.execute(testSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveSeriesWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(getWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      verify(getWatchListSeriesStatus.execute(testSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveSeriesWatchlist.execute(testSeriesDetail))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      when(getWatchListSeriesStatus.execute(testSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchSeriesDetail(tId);
      // assert
      expect(provider.seriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
