import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/pages/pages.dart';

class HomeMovieRobot {
  final WidgetTester tester;
  HomeMovieRobot(this.tester);

  Future<void> scrollMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byType(SingleChildScrollView);
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }

    /// expected
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
  }

  Future<void> clickSeeMorePopularMovies() async {
    final seePopularMoviesButtonFinder = find.byKey(
      const Key('btn_popular_movies'),
    );
    await tester.ensureVisible(seePopularMoviesButtonFinder);
    await tester.tap(seePopularMoviesButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(PopularMoviesPage), findsOneWidget);
  }

  Future<void> clickSeeMoreTopRatedMovies() async {
    final seeTopRatedMoviesButtonFinder =
        find.byKey(const Key('btn_top_rated_movies'));
    await tester.ensureVisible(seeTopRatedMoviesButtonFinder);
    await tester.tap(seeTopRatedMoviesButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(TopRatedMoviesPage), findsOneWidget);
  }

  Future<void> clickMovieItem({required String keyList}) async {
    final movieItemFinder = find.byKey(Key(keyList));
    await tester.ensureVisible(movieItemFinder);
    await tester.tap(movieItemFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(MovieDetailPage), findsOneWidget);
  }

  Future<void> clickSearchMovieButton() async {
    final searchButtonMovieFinder = find.byIcon(Icons.search);
    await tester.ensureVisible(searchButtonMovieFinder);
    await tester.tap(searchButtonMovieFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(SearchPage), findsOneWidget);
  }
}
