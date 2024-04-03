part of 'popular_series_bloc.dart';

sealed class PopularSeriesEvent extends Equatable {
  const PopularSeriesEvent();

  @override
  List<Object> get props => [];
}

final class FetchPopularSeriesEvent extends PopularSeriesEvent {}
