part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

final class FetchMovieDetailEvent extends MovieDetailEvent {
  final int tID;

  const FetchMovieDetailEvent({required this.tID});

  @override
  List<Object> get props => [tID];
}

final class FetchMovieRecommendationsEvent extends MovieDetailEvent {
  final int tID;

  const FetchMovieRecommendationsEvent({required this.tID});

  @override
  List<Object> get props => [tID];
}

final class SaveWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movie;

  const SaveWatchlistEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class RemoveWatchlistEvent extends MovieDetailEvent {
  final MovieDetail movie;

  const RemoveWatchlistEvent({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class GetWatchlistStatusEvent extends MovieDetailEvent {
  final int tID;

  const GetWatchlistStatusEvent({required this.tID});

  @override
  List<Object> get props => [tID];
}
