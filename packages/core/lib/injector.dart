import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/ssl_pinning.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movie/bloc/home_movie/home_movie_bloc.dart';
import 'package:movie/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movie/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/data/datasources/datasources.dart';
import 'package:movie/domain/repositories/repositories.dart';
import 'package:movie/domain/usecases/usecases.dart';
import 'package:series/bloc/home_series/home_series_bloc.dart';
import 'package:series/bloc/on_air_series/on_air_series_bloc.dart';
import 'package:series/bloc/popular_series.dart/popular_series_bloc.dart';
import 'package:series/bloc/series_detail/series_detail_bloc.dart';
import 'package:series/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:series/bloc/watchlist_series/watchlist_series_bloc.dart';
import 'package:series/data/datasources/datasources.dart';
import 'package:series/domain/repositories/repositories.dart';
import 'package:series/domain/usecases/usecases.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final database = await DatabaseHelper.initDb();
  // helper
  locator.registerFactory(() => DatabaseHelper(database: database));

  //HTTP Client
  final client = await getSSLPinningClient();
  locator.registerFactory<http.Client>(() => client);

  //BLOC
  locator.registerFactory(
    () => HomeMovieBloc(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMovieBloc(
      getPopularMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchMovieBloc(
      searchMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMovieBloc(
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistMovieBloc(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => HomeSeriesBloc(
      getOnAirSeries: locator(),
      getPopularSeries: locator(),
      getTopRatedSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => SeriesDetailBloc(
      getSeriesDetail: locator(),
      getSeriesRecommendations: locator(),
      getWatchListSeriesStatus: locator(),
      saveSeriesWatchlist: locator(),
      removeSeriesWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => OnAirSeriesBloc(
      getOnAirSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularSeriesBloc(
      getPopularSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedSeriesBloc(
      getTopRatedSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistSeriesBloc(
      getWatchlistSeries: locator(),
    ),
  );

  // // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetOnAirSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));

  // // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<SeriesRepository>(
    () => SeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(databaseHelper: locator()));
}
