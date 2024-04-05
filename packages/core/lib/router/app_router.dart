import 'package:core/presentation/pages/about_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/pages.dart';
import 'package:series/presentation/pages/pages.dart';
import 'package:core/injector.dart' as di;

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        return Builder(
          builder: (BuildContext context) {
            switch (settings.name) {
              case '/home':
                return HomeMoviePage(
                  locator: di.locator,
                );
              case '/home-series':
                return HomeSeriesPage(
                  locator: di.locator,
                );
              case PopularMoviesPage.routeName:
                return PopularMoviesPage(
                  locator: di.locator,
                );
              case PopularSeriesPage.routeName:
                return PopularSeriesPage(
                  locator: di.locator,
                );
              case TopRatedMoviesPage.routeName:
                return TopRatedMoviesPage(
                  locator: di.locator,
                );
              case TopRatedSeriesPage.routeName:
                return TopRatedSeriesPage(
                  locator: di.locator,
                );
              case OnAirSeriesPage.routeName:
                return OnAirSeriesPage(
                  locator: di.locator,
                );
              case MovieDetailPage.routeName:
                final id = settings.arguments as int;
                return MovieDetailPage(
                  id: id,
                  locator: di.locator,
                );
              case SeriesDetailPage.routeName:
                final id = settings.arguments as int;
                return SeriesDetailPage(
                  id: id,
                  locator: di.locator,
                );
              case SearchPage.routeName:
                return SearchPage(
                  locator: di.locator,
                );
              case SearchSeriesPage.routeName:
                return SearchSeriesPage(
                  locator: di.locator,
                );
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
