import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/series_detail/series_detail_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

import '../dummy_data/dummy_objects.dart';
import 'series_detail_test.mocks.dart';

@GenerateMocks([
  GetSeriesDetail,
  GetSeriesRecommendations,
  GetWatchListSeriesStatus,
  SaveSeriesWatchlist,
  RemoveSeriesWatchlist,
])
void main() {
  late SeriesDetailBloc bloc;
  late MockGetSeriesDetail mockGetSeriesDetail;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late MockGetWatchListSeriesStatus mockGetWatchListSeriesStatus;
  late MockSaveSeriesWatchlist mockSaveSeriesWatchlist;
  late MockRemoveSeriesWatchlist mockRemoveSeriesWatchlist;

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
    when(mockGetSeriesDetail.execute(tId))
        .thenAnswer((_) async => const Right(testSeriesDetail));
    when(mockGetSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tSeriesList));
  }

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    mockGetWatchListSeriesStatus = MockGetWatchListSeriesStatus();
    mockSaveSeriesWatchlist = MockSaveSeriesWatchlist();
    mockRemoveSeriesWatchlist = MockRemoveSeriesWatchlist();

    bloc = SeriesDetailBloc(
      getSeriesDetail: mockGetSeriesDetail,
      getSeriesRecommendations: mockGetSeriesRecommendations,
      getWatchListSeriesStatus: mockGetWatchListSeriesStatus,
      saveSeriesWatchlist: mockSaveSeriesWatchlist,
      removeSeriesWatchlist: mockRemoveSeriesWatchlist,
    );
  });

  group('Get Series Detail', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should get data from the usecase',
      build: () {
        //arrange
        arrangeUsecase();

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesDetailEvent(tID: tId)),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailLoaded(seriesDetail: testSeriesDetail),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should emit [SeriesDetailLoading, SeriesDetailFailed] when usecase fails',
      build: () {
        //arrange
        when(mockGetSeriesDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesDetailEvent(tID: tId)),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailFailed("Failed"),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should emit [SeriesDetailLoading, SeriesDetailFailed] when Exception occurs',
      build: () {
        //arrange
        when(mockGetSeriesDetail.execute(tId)).thenThrow(Exception("Failed"));

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesDetailEvent(tID: tId)),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailFailed("Exception: Failed"),
      ],
    );
  });

  group('Get Series Recommendations', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should get data from the usecase',
      build: () {
        //arrange
        arrangeUsecase();

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesRecommendationsEvent(tID: tId)),
      expect: () => [
        SeriesDetailLoading(),
        SeriesRecommendationLoaded(recommendationSeries: tSeriesList),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should emit [SeriesDetailLoading, SeriesDetailFailed] when usecase fails',
      build: () {
        //arrange
        when(mockGetSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesRecommendationsEvent(tID: tId)),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailFailed("Failed"),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should emit [SeriesDetailLoading, SeriesDetailFailed] when Exception occurs',
      build: () {
        //arrange
        when(mockGetSeriesRecommendations.execute(tId))
            .thenThrow(Exception("Failed"));

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchSeriesRecommendationsEvent(tID: tId)),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailFailed("Exception: Failed"),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should get status from the usecase',
      build: () {
        //arrange
        when(mockGetWatchListSeriesStatus.execute(any))
            .thenAnswer((_) async => true);

        return bloc;
      },
      act: (bloc) => bloc.add(const GetWatchlistStatusEvent(tID: tId)),
      expect: () => [
        SeriesDetailLoading(),
        const WatchlistStatusLoaded(true),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should emit [SeriesDetailLoading, SeriesDetailFailed] when Exception occurs',
      build: () {
        //arrange
        when(mockGetWatchListSeriesStatus.execute(any))
            .thenThrow("Exception Occured");

        return bloc;
      },
      act: (bloc) => bloc.add(const GetWatchlistStatusEvent(tID: tId)),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailFailed("Exception Occured"),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should save watchlist',
      build: () {
        //arrange
        when(mockSaveSeriesWatchlist.execute(any)).thenAnswer(
          (_) async => const Right(
            "Added to Watchlist",
          ),
        );
        when(mockGetWatchListSeriesStatus.execute(any))
            .thenAnswer((_) async => true);

        return bloc;
      },
      act: (bloc) => bloc.add(
        const SaveWatchlistEvent(
          serie: testSeriesDetail,
        ),
      ),
      expect: () => [
        SeriesDetailLoading(),
        const WatchlistChangeSuccess(message: "Added to Watchlist"),
        const WatchlistStatusLoaded(true),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should emit [SeriesDetailLoading, SeriesDetailFailed] when usecase give failure',
      build: () {
        //arrange
        when(mockSaveSeriesWatchlist.execute(any)).thenAnswer(
          (_) async => const Left(
            DatabaseFailure("Item Existed"),
          ),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(
        const SaveWatchlistEvent(
          serie: testSeriesDetail,
        ),
      ),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailFailed("Item Existed"),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should emit [SeriesDetailLoading, SeriesDetailFailed] when Exception occurs',
      build: () {
        //arrange
        when(mockSaveSeriesWatchlist.execute(any))
            .thenThrow("Exception Occured");

        return bloc;
      },
      act: (bloc) => bloc.add(
        const SaveWatchlistEvent(
          serie: testSeriesDetail,
        ),
      ),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailFailed("Exception Occured"),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should remove watchlist',
      build: () {
        //arrange
        when(mockRemoveSeriesWatchlist.execute(any)).thenAnswer(
          (_) async => const Right(
            "Added to Watchlist",
          ),
        );
        when(mockGetWatchListSeriesStatus.execute(any))
            .thenAnswer((_) async => true);

        return bloc;
      },
      act: (bloc) => bloc.add(
        const RemoveWatchlistEvent(
          serie: testSeriesDetail,
        ),
      ),
      expect: () => [
        SeriesDetailLoading(),
        const WatchlistChangeSuccess(message: "Added to Watchlist"),
        const WatchlistStatusLoaded(true),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should emit [SeriesDetailLoading, SeriesDetailFailed] when usecase give failure',
      build: () {
        //arrange
        when(mockRemoveSeriesWatchlist.execute(any)).thenAnswer(
          (_) async => const Left(
            DatabaseFailure("Item Not Existed"),
          ),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(
        const RemoveWatchlistEvent(
          serie: testSeriesDetail,
        ),
      ),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailFailed("Item Not Existed"),
      ],
    );

    blocTest<SeriesDetailBloc, SeriesDetailState>(
      'should emit [SeriesDetailLoading, SeriesDetailFailed] when Exception occurs',
      build: () {
        //arrange
        when(mockRemoveSeriesWatchlist.execute(any))
            .thenThrow("Exception Occured");

        return bloc;
      },
      act: (bloc) => bloc.add(
        const RemoveWatchlistEvent(
          serie: testSeriesDetail,
        ),
      ),
      expect: () => [
        SeriesDetailLoading(),
        const SeriesDetailFailed("Exception Occured"),
      ],
    );
  });
}
