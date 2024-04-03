part of 'popular_movie_bloc.dart';

sealed class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

final class PopularMovieInitial extends PopularMovieState {}

final class PopularMovieLoading extends PopularMovieState {}

final class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> movies;

  const PopularMovieLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class PopularMovieFailed extends PopularMovieState {
  final String error;

  const PopularMovieFailed({required this.error});

  @override
  List<Object> get props => [error];
}
