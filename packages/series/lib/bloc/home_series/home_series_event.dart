part of 'home_series_bloc.dart';

sealed class HomeSeriesEvent extends Equatable {
  const HomeSeriesEvent();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchOnAirSeriesEvent extends HomeSeriesEvent {}

final class FetchPopularSeriesEvent extends HomeSeriesEvent {}

final class FetchTopRatedSeriesEvent extends HomeSeriesEvent {}
