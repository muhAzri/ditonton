import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeriesDetail extends Equatable {
  const SeriesDetail(
      {required this.adult,
      required this.backdropPath,
      required this.genres,
      required this.id,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.firstAirDate,
      required this.name,
      required this.voteAverage,
      required this.voteCount,
      required this.seasons});

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final List<Season> seasons;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final String name;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        firstAirDate,
        name,
        voteAverage,
        voteCount,
      ];
}
