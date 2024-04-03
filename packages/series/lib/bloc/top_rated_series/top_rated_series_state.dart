part of 'top_rated_series_bloc.dart';

sealed class TopRatedSeriesState extends Equatable {
  const TopRatedSeriesState();

  @override
  List<Object> get props => [];
}

final class TopRatedSeriesInitial extends TopRatedSeriesState {}

final class TopRatedSeriesLoading extends TopRatedSeriesState {}

final class TopRatedSeriesLoaded extends TopRatedSeriesState {
  final List<Series> series;

  const TopRatedSeriesLoaded({required this.series});

  @override
  List<Object> get props => [series];
}

final class TopRatedSeriesFailed extends TopRatedSeriesState {
  final String error;

  const TopRatedSeriesFailed({required this.error});

  @override
  List<Object> get props => [error];
}
