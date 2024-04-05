part of 'watchlist_movie_bloc.dart';

sealed class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

final class WatchlistMovieInitial extends WatchlistMovieState {}

final class WatchlistMovieLoading extends WatchlistMovieState {}

final class WatchlistMovieLoaded extends WatchlistMovieState {
  final List<Movie> movies;

  const WatchlistMovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

final class WatchlistMovieFailed extends WatchlistMovieState {
  final String error;

  const WatchlistMovieFailed(this.error);

  @override
  List<Object> get props => [error];
}
