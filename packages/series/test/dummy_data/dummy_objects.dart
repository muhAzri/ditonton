import 'package:core/domain/entities/entities.dart';
import 'package:series/data/models/series_table.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';

const testSeriesTable = SeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

const testWatchlistSeries = Series.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testSeriesDetail = SeriesDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  seasons: [
    Season(
      airDate: "2010-12-05",
      episodeCount: 272,
      id: 3627,
      name: "Specials",
      overview: "",
      posterPath: "/kMTcwNRfFKCZ0O2OaBZS0nZ2AIe.jpg",
      seasonNumber: 0,
      voteAverage: 0,
    )
  ],
  id: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
  firstAirDate: '2002-05-01',
);

const testSeries = Series(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalName: 'Breaking Bad',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  name: 'Breaking Bad',
  voteAverage: 7.2,
  voteCount: 13507,
);

final testSeriesList = [testSeries];
