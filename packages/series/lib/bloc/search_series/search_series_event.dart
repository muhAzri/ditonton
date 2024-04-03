part of 'search_series_bloc.dart';

sealed class SearchSeriesEvent extends Equatable {
  const SearchSeriesEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class SearchEvent extends SearchSeriesEvent {
  final String query;

  const SearchEvent(this.query);

  @override
  List<Object> get props => [query];
}
