part of 'popular_series_bloc.dart';

sealed class PopularSeriesEvent extends Equatable {
  const PopularSeriesEvent();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchPopularSeriesEvent extends PopularSeriesEvent {}
