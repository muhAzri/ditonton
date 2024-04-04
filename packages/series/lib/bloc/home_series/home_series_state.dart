part of 'home_series_bloc.dart';

sealed class HomeSeriesState extends Equatable {
  const HomeSeriesState();

  @override
  List<Object> get props => [];
}

final class HomeSeriesInitial extends HomeSeriesState {}

final class HomeSeriesLoading extends HomeSeriesState {}

final class OnAirSeriesLoaded extends HomeSeriesState {
  final List<Series> onAirSeries;

  const OnAirSeriesLoaded({
    required this.onAirSeries,
  });

  @override
  List<Object> get props => [onAirSeries];
}

final class PopularSeriesLoaded extends HomeSeriesState {
  final List<Series> popularSeries;

  const PopularSeriesLoaded({
    required this.popularSeries,
  });

  @override
  List<Object> get props => [popularSeries];
}

final class TopRatedSeriesLoaded extends HomeSeriesState {
  final List<Series> topRatedSeries;

  const TopRatedSeriesLoaded({
    required this.topRatedSeries,
  });

  @override
  List<Object> get props => [topRatedSeries];
}

final class HomeSeriesFailed extends HomeSeriesState {
  final String error;

  const HomeSeriesFailed({required this.error});

  @override
  List<Object> get props => [error];
}
