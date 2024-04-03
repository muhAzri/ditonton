part of 'top_rated_series_bloc.dart';

sealed class TopRatedSeriesEvent extends Equatable {
  const TopRatedSeriesEvent();

  @override
  List<Object> get props => [];
}

final class FetchTopRatedSeriesEvent extends TopRatedSeriesEvent {}
