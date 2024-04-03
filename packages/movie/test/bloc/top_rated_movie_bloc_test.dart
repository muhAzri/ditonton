import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/bloc/top_rated_movie/top_rated_movie_bloc.dart';

import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/usecases.dart';

import 'top_rated_movie_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMovieBloc bloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    bloc = TopRatedMovieBloc(getTopRatedMovies: mockGetTopRatedMovies);
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
      "should Emit[TopRatedMovieLoading, TopRatedMovieLoaded] Data When usecases is success",
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieLoaded(movies: tMovieList),
      ],
    );

    blocTest(
      "should Emit[TopRatedMovieLoading, TopRatedMovieFailed] Data When usecases is failed",
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMovieLoading(),
        const TopRatedMovieFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[TopRatedMovieLoading, TopRatedMovieFailed] Data When Exception Occurs",
      build: () {
        when(mockGetTopRatedMovies.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMoviesEvent()),
      expect: () => [
        TopRatedMovieLoading(),
        const TopRatedMovieFailed(error: "Exception Occurs"),
      ],
    );
  });
}
