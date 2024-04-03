import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/bloc/watchlist_movie/watchlist_movie_bloc.dart';

import 'package:movie/domain/usecases/usecases.dart';

import '../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMovieBloc bloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    bloc = WatchlistMovieBloc(getWatchlistMovies: mockGetWatchlistMovies);
  });

  group("Popular Movie Bloc Test", () {
    blocTest(
      "should Emit[WatchlistMovieLoading, WatchlistMovieLoaded] Data When usecases is success",
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Right([testWatchlistMovie]));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovieEvents()),
      expect: () => [
        WatchlistMovieLoading(),
        const WatchlistMovieLoaded([testWatchlistMovie]),
      ],
    );

    blocTest(
      "should Emit[WatchlistMovieLoading, WatchlistMovieFailed] Data When usecases is failed",
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovieEvents()),
      expect: () => [
        WatchlistMovieLoading(),
        const WatchlistMovieFailed("Failed"),
      ],
    );

    blocTest(
      "should Emit[WatchlistMovieLoading, WatchlistMovieFailed] Data When Exception Occurs",
      build: () {
        when(mockGetWatchlistMovies.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistMovieEvents()),
      expect: () => [
        WatchlistMovieLoading(),
        const WatchlistMovieFailed("Exception Occurs"),
      ],
    );
  });
}
