import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/usecases.dart';

import '../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  const tId = 1;

  const tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  void arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    when(mockGetMovieRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();

    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  group('Get Movie Detail', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should get data from the usecase',
      build: () {
        //arrange
        arrangeUsecase();

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailEvent(tID: tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailLoaded(movieDetail: testMovieDetail),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [MovieDetailLoading, MovieDetailFailed] when usecase fails',
      build: () {
        //arrange
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailEvent(tID: tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailFailed("Failed"),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [MovieDetailLoading, MovieDetailFailed] when Exception occurs',
      build: () {
        //arrange
        when(mockGetMovieDetail.execute(tId)).thenThrow(Exception("Failed"));

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMovieDetailEvent(tID: tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailFailed("Exception: Failed"),
      ],
    );
  });

  group('Get Movie Recommendations', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should get data from the usecase',
      build: () {
        //arrange
        arrangeUsecase();

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMovieRecommendationsEvent(tID: tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieRecommendationLoaded(recommendationMovies: tMovies),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [MovieDetailLoading, MovieDetailFailed] when usecase fails',
      build: () {
        //arrange
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Failed')));

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMovieRecommendationsEvent(tID: tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailFailed("Failed"),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [MovieDetailLoading, MovieDetailFailed] when Exception occurs',
      build: () {
        //arrange
        when(mockGetMovieRecommendations.execute(tId))
            .thenThrow(Exception("Failed"));

        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMovieRecommendationsEvent(tID: tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailFailed("Exception: Failed"),
      ],
    );
  });

  group('Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should get status from the usecase',
      build: () {
        //arrange
        when(mockGetWatchlistStatus.execute(any)).thenAnswer((_) async => true);

        return bloc;
      },
      act: (bloc) => bloc.add(const GetWatchlistStatusEvent(tID: tId)),
      expect: () => [
        MovieDetailLoading(),
        const WatchlistStatusLoaded(true),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [MovieDetailLoading, MovieDetailFailed] when Exception occurs',
      build: () {
        //arrange
        when(mockGetWatchlistStatus.execute(any))
            .thenThrow("Exception Occured");

        return bloc;
      },
      act: (bloc) => bloc.add(const GetWatchlistStatusEvent(tID: tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailFailed("Exception Occured"),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should save watchlist',
      build: () {
        //arrange
        when(mockSaveWatchlist.execute(any)).thenAnswer(
          (_) async => const Right(
            "Added to Watchlist",
          ),
        );
        when(mockGetWatchlistStatus.execute(any)).thenAnswer((_) async => true);

        return bloc;
      },
      act: (bloc) => bloc.add(
        const SaveWatchlistEvent(
          movie: testMovieDetail,
        ),
      ),
      expect: () => [
        MovieDetailLoading(),
        const WatchlistChangeSuccess(message: "Added to Watchlist"),
        const WatchlistStatusLoaded(true),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [MovieDetailLoading, MovieDetailFailed] when usecase give failure',
      build: () {
        //arrange
        when(mockSaveWatchlist.execute(any)).thenAnswer(
          (_) async => const Left(
            DatabaseFailure("Item Existed"),
          ),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(
        const SaveWatchlistEvent(
          movie: testMovieDetail,
        ),
      ),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailFailed("Item Existed"),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [MovieDetailLoading, MovieDetailFailed] when Exception occurs',
      build: () {
        //arrange
        when(mockSaveWatchlist.execute(any)).thenThrow("Exception Occured");

        return bloc;
      },
      act: (bloc) => bloc.add(
        const SaveWatchlistEvent(
          movie: testMovieDetail,
        ),
      ),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailFailed("Exception Occured"),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should remove watchlist',
      build: () {
        //arrange
        when(mockRemoveWatchlist.execute(any)).thenAnswer(
          (_) async => const Right(
            "Added to Watchlist",
          ),
        );
        when(mockGetWatchlistStatus.execute(any)).thenAnswer((_) async => true);

        return bloc;
      },
      act: (bloc) => bloc.add(
        const RemoveWatchlistEvent(
          movie: testMovieDetail,
        ),
      ),
      expect: () => [
        MovieDetailLoading(),
        const WatchlistChangeSuccess(message: "Added to Watchlist"),
        const WatchlistStatusLoaded(true),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [MovieDetailLoading, MovieDetailFailed] when usecase give failure',
      build: () {
        //arrange
        when(mockRemoveWatchlist.execute(any)).thenAnswer(
          (_) async => const Left(
            DatabaseFailure("Item Not Existed"),
          ),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(
        const RemoveWatchlistEvent(
          movie: testMovieDetail,
        ),
      ),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailFailed("Item Not Existed"),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit [MovieDetailLoading, MovieDetailFailed] when Exception occurs',
      build: () {
        //arrange
        when(mockRemoveWatchlist.execute(any)).thenThrow("Exception Occured");

        return bloc;
      },
      act: (bloc) => bloc.add(
        const RemoveWatchlistEvent(
          movie: testMovieDetail,
        ),
      ),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailFailed("Exception Occured"),
      ],
    );
  });
}
