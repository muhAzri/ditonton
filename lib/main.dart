import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/series/home_series_page.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movies/home_movie_page.dart';
import 'package:ditonton/presentation/pages/series/on_air_series_page.dart';
import 'package:ditonton/presentation/pages/movies/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/series/popular_series_page.dart';
import 'package:ditonton/presentation/pages/movies/search_page.dart';
import 'package:ditonton/presentation/pages/series/search_series_page.dart';
import 'package:ditonton/presentation/pages/series/series_detail_page.dart';
import 'package:ditonton/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/series/top_rated_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/provider/movies/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movies/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movies/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/series/on_air_series_notifier.dart';
import 'package:ditonton/presentation/provider/movies/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/series/popular_series_notifier.dart';
import 'package:ditonton/presentation/provider/series/series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/series/series_list_notifier.dart';
import 'package:ditonton/presentation/provider/series/series_search_notifier.dart';
import 'package:ditonton/presentation/provider/movies/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/series/top_rated_series_notifier.dart';
import 'package:ditonton/presentation/provider/movies/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/series/watchlist_series_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnAirSeriesNotifier>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case '/home-series':
              return MaterialPageRoute(builder: (_) => const HomeSeriesPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularMoviesPage());
            case PopularSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const PopularSeriesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedMoviesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const TopRatedSeriesPage());
            case OnAirSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const OnAirSeriesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => const SearchPage());
            case SearchSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => const SearchSeriesPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
