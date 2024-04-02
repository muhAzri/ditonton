part of 'home_movie_bloc.dart';

sealed class HomeMovieState extends Equatable {
  const HomeMovieState();

  @override
  List<Object> get props => [];
}

final class HomeMovieInitial extends HomeMovieState {}

final class HomeMovieLoading extends HomeMovieState {}

final class NowPlayingMoviesLoaded extends HomeMovieState {
  final List<Movie> nowPlayingMovies;

  const NowPlayingMoviesLoaded({
    required this.nowPlayingMovies,
  });

  @override
  List<Object> get props => [nowPlayingMovies];
}

final class PopularMoviesLoaded extends HomeMovieState {
  final List<Movie> popularMovies;

  const PopularMoviesLoaded({
    required this.popularMovies,
  });

  @override
  List<Object> get props => [popularMovies];
}

final class TopRatedMoviesLoaded extends HomeMovieState {
  final List<Movie> topRatedMovies;

  const TopRatedMoviesLoaded({
    required this.topRatedMovies,
  });

  @override
  List<Object> get props => [topRatedMovies];
}

final class HomeMovieFailed extends HomeMovieState {
  final String error;

  const HomeMovieFailed({required this.error});

  @override
  List<Object> get props => [error];
}
