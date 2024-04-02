part of 'search_movie_bloc.dart';

sealed class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

final class SearchEvent extends SearchMovieEvent {
  final String query;

  const SearchEvent(this.query);

  @override
  List<Object> get props => [query];
}
