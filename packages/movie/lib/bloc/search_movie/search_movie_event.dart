part of 'search_movie_bloc.dart';

sealed class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class SearchEvent extends SearchMovieEvent {
  final String query;

  const SearchEvent(this.query);

  @override
  List<Object> get props => [query];
}
