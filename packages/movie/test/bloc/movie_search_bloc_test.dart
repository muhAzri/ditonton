import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/usecases.dart';

import 'movie_search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc bloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    bloc = SearchMovieBloc(searchMovies: mockSearchMovies);
  });

  const tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  group("MovieSearch Bloc Test", () {
    blocTest(
      "should Emit[SearchMovieLoading, SearchMovieLoaded] Data When usecases is success",
      build: () {
        when(mockSearchMovies.execute(any))
            .thenAnswer((_) async => Right(tMovieList));

        return bloc;
      },
      act: (bloc) => bloc.add(const SearchEvent(tQuery)),
      expect: () => [
        SearchMovieLoading(),
        SearchMovieLoaded(tMovieList),
      ],
    );

    blocTest(
      "should Emit[SearchMovieLoading, SearchMovieFailed] Data When usecases is failed",
      build: () {
        when(mockSearchMovies.execute(any))
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(const SearchEvent(tQuery)),
      expect: () => [
        SearchMovieLoading(),
        const SearchMovieFailed("Failed"),
      ],
    );

    blocTest(
      "should Emit[SearchMovieLoading, SearchMovieFailed] Data When Exception Occurs",
      build: () {
        when(mockSearchMovies.execute(any)).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(const SearchEvent(tQuery)),
      expect: () => [
        SearchMovieLoading(),
        const SearchMovieFailed("Exception Occurs"),
      ],
    );
  });
}
