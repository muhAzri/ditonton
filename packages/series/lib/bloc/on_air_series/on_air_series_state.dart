part of 'on_air_series_bloc.dart';

sealed class OnAirSeriesState extends Equatable {
  const OnAirSeriesState();

  @override
  List<Object> get props => [];
}

final class OnAirSeriesInitial extends OnAirSeriesState {}

final class OnAirSeriesLoading extends OnAirSeriesState {}

final class OnAirSeriesLoaded extends OnAirSeriesState {
  final List<Series> series;

  const OnAirSeriesLoaded({required this.series});

  @override
  List<Object> get props => [series];
}

final class OnAirSeriesFailed extends OnAirSeriesState {
  final String error;

  const OnAirSeriesFailed({required this.error});

  @override
  List<Object> get props => [error];
}
