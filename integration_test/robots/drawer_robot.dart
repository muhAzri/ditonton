import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:series/presentation/pages/home_series_page.dart';

class DrawerAppRobot {
  final WidgetTester tester;
  DrawerAppRobot(this.tester);

  Future<void> clickNavigationDrawerButtonMovie() async {
    final drawerButtonFinder = find.byIcon(Icons.menu);
    await tester.ensureVisible(drawerButtonFinder);
    await tester.tap(drawerButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(DrawerHeader), findsOneWidget);
    expect(find.text("ditonton@dicoding.com"), findsOne);

    expect(
      find.byType(ListTile),
      findsNWidgets(4),
    );

    expect(find.text("Movies"), findsOne);
    expect(find.text("TV Series"), findsOne);
    expect(find.text("Watchlist"), findsOne);
    expect(find.text("About"), findsOne);
  }

  Future<void> clickNavigationDrawerButtonTv() async {
    final drawerButtonFinder = find.byKey(const Key('drawerButtonTv'));
    await tester.ensureVisible(drawerButtonFinder);
    await tester.tap(drawerButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byKey(const Key('contentDrawer')), findsOneWidget);
    expect(find.byKey(const Key('tvListTile')), findsOneWidget);
    expect(find.byKey(const Key('watchlistListTile')), findsOneWidget);
  }

  Future<void> clickMovieListTile() async {
    final homeButton = find.text("Movies");
    await tester.ensureVisible(homeButton);

    await tester.tap(homeButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomeSeriesPage), findsNothing);
    expect(find.byType(HomeMoviePage), findsOneWidget);
  }

  Future<void> clickTvListTile() async {
    final homeButton = find.text("TV Series");
    await tester.ensureVisible(homeButton);

    await tester.tap(homeButton);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(HomeSeriesPage), findsOneWidget);
  }

  Future<void> clickWatchlistListTile() async {
    final watchlistButton = find.text('Watchlist');
    await tester.ensureVisible(watchlistButton);

    await tester.tap(watchlistButton);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(WatchlistPage), findsOneWidget);
  }

  Future<void> clickWatchlistSeriesSection() async {
    final watchlistSeriesButton = find.text('Series');
    await tester.ensureVisible(watchlistSeriesButton);

    await tester.tap(watchlistSeriesButton);
    await tester.pumpAndSettle();
  }
}
