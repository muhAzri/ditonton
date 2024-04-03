part of 'top_rated_movie_bloc.dart';

sealed class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

final class TopRatedMovieInitial extends TopRatedMovieState {}

final class TopRatedMovieLoading extends TopRatedMovieState {}

final class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<Movie> movies;

  const TopRatedMovieLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class TopRatedMovieFailed extends TopRatedMovieState {
  final String error;

  const TopRatedMovieFailed({required this.error});

  @override
  List<Object> get props => [error];
}
