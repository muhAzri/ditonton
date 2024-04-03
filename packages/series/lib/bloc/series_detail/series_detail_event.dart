part of 'series_detail_bloc.dart';

sealed class SeriesDetailEvent extends Equatable {
  const SeriesDetailEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchSeriesDetailEvent extends SeriesDetailEvent {
  final int tID;

  const FetchSeriesDetailEvent({required this.tID});

  @override
  List<Object> get props => [tID];
}

final class FetchSeriesRecommendationsEvent extends SeriesDetailEvent {
  final int tID;

  const FetchSeriesRecommendationsEvent({required this.tID});

  @override
  List<Object> get props => [tID];
}

final class SaveWatchlistEvent extends SeriesDetailEvent {
  final SeriesDetail serie;

  const SaveWatchlistEvent({required this.serie});

  @override
  List<Object> get props => [serie];
}

final class RemoveWatchlistEvent extends SeriesDetailEvent {
  final SeriesDetail serie;

  const RemoveWatchlistEvent({required this.serie});

  @override
  List<Object> get props => [serie];
}

final class GetWatchlistStatusEvent extends SeriesDetailEvent {
  final int tID;

  const GetWatchlistStatusEvent({required this.tID});

  @override
  List<Object> get props => [tID];
}
