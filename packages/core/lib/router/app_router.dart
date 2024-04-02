import 'package:core/presentation/pages/about_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/pages.dart';
import 'package:series/presentation/pages/pages.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return Builder(
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/home':
                return const HomeMoviePage();
              case '/home-series':
                return const HomeSeriesPage();
              case PopularMoviesPage.routeName:
                return const PopularMoviesPage();
              case PopularSeriesPage.routeName:
                return const PopularSeriesPage();
              case TopRatedMoviesPage.routeName:
                return const TopRatedMoviesPage();
              case TopRatedSeriesPage.routeName:
                return const TopRatedSeriesPage();
              case OnAirSeriesPage.routeName:
                return const OnAirSeriesPage();
              case MovieDetailPage.routeName:
                final id = settings.arguments as int;
                return MovieDetailPage(id: id);
              case SeriesDetailPage.routeName:
                final id = settings.arguments as int;
                return SeriesDetailPage(id: id);
              case SearchPage.routeName:
                return const SearchPage();
              case SearchSeriesPage.routeName:
                return const SearchSeriesPage();
              case WatchlistPage.routeName:
                return const WatchlistPage();
              case AboutPage.routeName:
                return const AboutPage();
              default:
                return const NamedRouteNotFound();
            }
          },
        );
      },
    );
  }
}

class NamedRouteNotFound extends StatelessWidget {
  const NamedRouteNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Page Not Found :()',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }
}
