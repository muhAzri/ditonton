import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/usecases.dart';

import 'home_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc bloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = PopularMovieBloc(getPopularMovies: mockGetPopularMovies);
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

  group("Popular Movie Bloc Test", () {
    blocTest(
      "should Emit[PopularMovieLoading, PopularMovieLoaded] Data When usecases is success",
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieLoaded(movies: tMovieList),
      ],
    );

    blocTest(
      "should Emit[PopularMovieLoading, PopularMovieFailed] Data When usecases is failed",
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        PopularMovieLoading(),
        const PopularMovieFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[PopularMovieLoading, PopularMovieFailed] Data When Exception Occurs",
      build: () {
        when(mockGetPopularMovies.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularMoviesEvent()),
      expect: () => [
        PopularMovieLoading(),
        const PopularMovieFailed(error: "Exception Occurs"),
      ],
    );
  });
}
