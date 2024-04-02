import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/usecases.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailInitial()) {
    on<FetchMovieDetailEvent>(onFetchMovieDetail);
    on<FetchMovieRecommendationsEvent>(onFetchMovieRecommendations);
    on<GetWatchlistStatusEvent>(onFetchWatchListStatus);
    on<SaveWatchlistEvent>(onSaveWatchlist);
    on<RemoveWatchlistEvent>(onRemoveWatchlist);
  }

  Future<void> onFetchMovieDetail(
    FetchMovieDetailEvent event,
    emit,
  ) async {
    try {
      emit(MovieDetailLoading());

      final result = await getMovieDetail.execute(event.tID);

      result.fold(
        (error) {
          emit(
            MovieDetailFailed(error.message),
          );
        },
        (movieData) {
          emit(
            MovieDetailLoaded(movieDetail: movieData),
          );
        },
      );
    } catch (e) {
      emit(MovieDetailFailed(e.toString()));
    }
  }

  Future<void> onFetchMovieRecommendations(
    FetchMovieRecommendationsEvent event,
    emit,
  ) async {
    try {
      emit(MovieDetailLoading());

      final result = await getMovieRecommendations.execute(event.tID);

      result.fold(
        (error) {
          emit(
            MovieDetailFailed(error.message),
          );
        },
        (moviesData) {
          emit(
            MovieRecommendationLoaded(
              recommendationMovies: moviesData,
            ),
          );
        },
      );
    } catch (e) {
      emit(MovieDetailFailed(e.toString()));
    }
  }

  Future<void> onFetchWatchListStatus(
    GetWatchlistStatusEvent event,
    emit,
  ) async {
    try {
      emit(MovieDetailLoading());

      final result = await getWatchListStatus.execute(event.tID);

      emit(WatchlistStatusLoaded(result));
    } catch (e) {
      emit(MovieDetailFailed(e.toString()));
    }
  }

  Future<void> onSaveWatchlist(
    SaveWatchlistEvent event,
    emit,
  ) async {
    try {
      emit(MovieDetailLoading());

      final result = await saveWatchlist.execute(event.movie);

      await result.fold(
        (error) {
          emit(
            MovieDetailFailed(error.message),
          );
        },
        (watchlistMessage) async {
          emit(WatchlistChangeSuccess(message: watchlistMessage));
          final newResult = await getWatchListStatus.execute(
            event.movie.id,
          );
          emit(WatchlistStatusLoaded(newResult));
        },
      );
    } catch (e) {
      emit(MovieDetailFailed(e.toString()));
    }
  }

  Future<void> onRemoveWatchlist(
    RemoveWatchlistEvent event,
    emit,
  ) async {
    try {
      emit(MovieDetailLoading());

      final result = await removeWatchlist.execute(event.movie);

      await result.fold(
        (error) {
          emit(
            MovieDetailFailed(error.message),
          );
        },
        (watchlistMessage) async {
          emit(WatchlistChangeSuccess(message: watchlistMessage));
          final newResult = await getWatchListStatus.execute(
            event.movie.id,
          );
          emit(WatchlistStatusLoaded(newResult));
        },
      );
    } catch (e) {
      emit(MovieDetailFailed(e.toString()));
    }
  }
}
