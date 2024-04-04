part of 'search_series_bloc.dart';

sealed class SearchSeriesState extends Equatable {
  const SearchSeriesState();

  @override
  List<Object> get props => [];
}

final class SearchSeriesInitial extends SearchSeriesState {}

final class SearchSeriesLoading extends SearchSeriesState {}

final class SearchSeriesLoaded extends SearchSeriesState {
  final List<Series> series;

  const SearchSeriesLoaded(this.series);

  @override
  List<Object> get props => [series];
}

final class SearchSeriesFailed extends SearchSeriesState {
  final String error;

  const SearchSeriesFailed(this.error);

  @override
  List<Object> get props => [error];
}
