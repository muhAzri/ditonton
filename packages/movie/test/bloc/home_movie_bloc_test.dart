import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/bloc/home_movie/home_movie_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/usecases.dart';

import 'home_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late HomeMovieBloc bloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = HomeMovieBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

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
  final tMovieList = <Movie>[tMovie];

  group('now playing movies', () {
    blocTest(
      "should Emit[HomeMovieLoading, NowPlayingMoviesLoaded] Data When usecases is success",
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMoviesEvent()),
      expect: () => [
        HomeMovieLoading(),
        NowPlayingMoviesLoaded(nowPlayingMovies: tMovieList),
      ],
    );

    blocTest(
      "should Emit[HomeMovieLoading, HomeMovieFailed] Data When usecases is failed",
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMoviesEvent()),
      expect: () => [
        HomeMovieLoading(),
        const HomeMovieFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[HomeMovieLoading, HomeMovieFailed] Data When Exception Occurs",
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayingMoviesEvent()),
      expect: () => [
        HomeMovieLoading(),
        const HomeMovieFailed(error: "Exception Occurs"),
      ],
    );
  });

  group('popular movies', () {
    blocTest(
      "should Emit[HomeMovieLoading, PopularMoviesLoaded] Data When usecases is success",
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        HomeMovieLoading(),
        PopularMoviesLoaded(popularMovies: tMovieList),
      ],
    );

    blocTest(
      "should Emit[HomeMovieLoading, HomeMovieFailed] Data When usecases is failed",
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        HomeMovieLoading(),
        const HomeMovieFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[HomeMovieLoading, HomeMovieFailed] Data When Exception Occurs",
      build: () {
        when(mockGetPopularMovies.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        HomeMovieLoading(),
        const HomeMovieFailed(error: "Exception Occurs"),
      ],
    );
  });

  group('top rated movies', () {
    blocTest(
      "should Emit[HomeMovieLoading, TopRatedMoviesLoaded] Data When usecases is success",
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        HomeMovieLoading(),
        TopRatedMoviesLoaded(topRatedMovies: tMovieList),
      ],
    );

    blocTest(
      "should Emit[HomeMovieLoading, HomeMovieFailed] Data When usecases is failed",
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        HomeMovieLoading(),
        const HomeMovieFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[HomeMovieLoading, HomeMovieFailed] Data When Exception Occurs",
      build: () {
        when(mockGetTopRatedMovies.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        HomeMovieLoading(),
        const HomeMovieFailed(error: "Exception Occurs"),
      ],
    );
  });
}
