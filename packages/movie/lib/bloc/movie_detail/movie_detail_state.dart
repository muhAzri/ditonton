part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;

  const MovieDetailLoaded({required this.movieDetail});

  @override
  List<Object> get props => [movieDetail];
}

final class MovieRecommendationLoaded extends MovieDetailState {
  final List<Movie> recommendationMovies;

  const MovieRecommendationLoaded({
    required this.recommendationMovies,
  });

  @override
  List<Object> get props => [recommendationMovies];
}

final class WatchlistStatusLoaded extends MovieDetailState {
  final bool isWatchlist;

  const WatchlistStatusLoaded(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}

final class WatchlistChangeSuccess extends MovieDetailState {
  final String message;

  const WatchlistChangeSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class MovieDetailFailed extends MovieDetailState {
  final String error;

  const MovieDetailFailed(this.error);

  @override
  List<Object> get props => [error];
}
