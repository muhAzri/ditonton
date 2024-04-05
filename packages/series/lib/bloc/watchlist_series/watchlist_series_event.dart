part of 'watchlist_series_bloc.dart';

sealed class WatchlistSeriesEvent extends Equatable {
  const WatchlistSeriesEvent();

  @override
  List<Object> get props => [];
}

final class FetchWatchlistSeriesEvents extends WatchlistSeriesEvent {}
