part of 'top_rated_movie_bloc.dart';

sealed class TopRatedMovieEvent extends Equatable {
  const TopRatedMovieEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchTopRatedMoviesEvent extends TopRatedMovieEvent {}
