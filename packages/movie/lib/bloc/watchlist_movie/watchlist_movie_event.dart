part of 'watchlist_movie_bloc.dart';

sealed class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchWatchlistMovieEvents extends WatchlistMovieEvent {}
