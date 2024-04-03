part of 'home_series_bloc.dart';

sealed class HomeSeriesEvent extends Equatable {
  const HomeSeriesEvent();

  @override
  List<Object> get props => [];
}

final class FetchOnAirSeriesEvent extends HomeSeriesEvent {}

final class FetchPopularSeriesEvent extends HomeSeriesEvent {}

final class FetchTopRatedSeriesEvent extends HomeSeriesEvent {}
