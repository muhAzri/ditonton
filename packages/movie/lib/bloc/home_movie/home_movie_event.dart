part of 'home_movie_bloc.dart';

sealed class HomeMovieEvent extends Equatable {
  const HomeMovieEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchNowPlayingMoviesEvent extends HomeMovieEvent {}

final class FetchPopularMoviesEvent extends HomeMovieEvent {}

final class FetchTopRatedMoviesEvent extends HomeMovieEvent {}
