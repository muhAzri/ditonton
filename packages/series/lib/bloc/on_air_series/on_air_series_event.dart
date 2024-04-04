part of 'on_air_series_bloc.dart';

sealed class OnAirSeriesEvent extends Equatable {
  const OnAirSeriesEvent();

  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchOnAirSeriesEvent extends OnAirSeriesEvent {}
