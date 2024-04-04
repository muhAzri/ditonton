part of 'watchlist_series_bloc.dart';

sealed class WatchlistSeriesState extends Equatable {
  const WatchlistSeriesState();

  @override
  List<Object> get props => [];
}

final class WatchlistSeriesInitial extends WatchlistSeriesState {}

final class WatchlistSeriesLoading extends WatchlistSeriesState {}

final class WatchlistSeriesLoaded extends WatchlistSeriesState {
  final List<Series> series;

  const WatchlistSeriesLoaded(this.series);

  @override
  List<Object> get props => [series];
}

final class WatchlistSeriesFailed extends WatchlistSeriesState {
  final String error;

  const WatchlistSeriesFailed(this.error);

  @override
  List<Object> get props => [error];
}
