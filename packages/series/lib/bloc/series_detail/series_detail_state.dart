part of 'series_detail_bloc.dart';

sealed class SeriesDetailState extends Equatable {
  const SeriesDetailState();

  @override
  List<Object> get props => [];
}

final class SeriesDetailInitial extends SeriesDetailState {}

final class SeriesDetailLoading extends SeriesDetailState {}

final class SeriesDetailLoaded extends SeriesDetailState {
  final SeriesDetail seriesDetail;
  const SeriesDetailLoaded({required this.seriesDetail});

  @override
  List<Object> get props => [seriesDetail];
}

final class SeriesRecommendationLoaded extends SeriesDetailState {
  final List<Series> recommendationSeries;

  const SeriesRecommendationLoaded({
    required this.recommendationSeries,
  });

  @override
  List<Object> get props => [recommendationSeries];
}

final class WatchlistStatusLoaded extends SeriesDetailState {
  final bool isWatchlist;

  const WatchlistStatusLoaded(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}

final class WatchlistChangeSuccess extends SeriesDetailState {
  final String message;

  const WatchlistChangeSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class SeriesDetailFailed extends SeriesDetailState {
  final String error;

  const SeriesDetailFailed(this.error);

  @override
  List<Object> get props => [error];
}
