part of 'top_rated_series_bloc.dart';

sealed class TopRatedSeriesEvent extends Equatable {
  const TopRatedSeriesEvent();

  // Sealed Class Untestable
  // coverage:ignore-start
  @override
  List<Object> get props => [];
  // coverage:ignore-end
}

final class FetchTopRatedSeriesEvent extends TopRatedSeriesEvent {}
