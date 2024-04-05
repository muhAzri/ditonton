import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/usecases.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({required this.getWatchlistMovies})
      : super(
          WatchlistMovieInitial(),
        ) {
    on<FetchWatchlistMovieEvents>(onFetchWatchlistMovies);
  }

  Future<void> onFetchWatchlistMovies(
      FetchWatchlistMovieEvents event, emit) async {
    try {
      emit(WatchlistMovieLoading());

      final result = await getWatchlistMovies.execute();

      result.fold(
        (error) {
          emit(
            WatchlistMovieFailed(error.message),
          );
        },
        (moviesData) {
          emit(
            WatchlistMovieLoaded(moviesData),
          );
        },
      );
    } catch (e) {
      emit(
        WatchlistMovieFailed(
          e.toString(),
        ),
      );
    }
  }
}
