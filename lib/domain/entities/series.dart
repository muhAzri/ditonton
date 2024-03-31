import 'package:equatable/equatable.dart';

class Series extends Equatable {
  const Series({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  const Series.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
    this.backdropPath,
    this.genreIds,
    this.originalName,
    this.popularity,
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
  });

  final String? backdropPath;
  final List<int>? genreIds;
  final int id;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? name;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        originalName,
        overview,
        popularity,
        posterPath,
        releaseDate,
        name,
        voteAverage,
        voteCount,
      ];
}
