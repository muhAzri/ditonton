import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/pages/pages.dart';

class HomeSeriesRobot {
  final WidgetTester tester;
  HomeSeriesRobot(this.tester);

  Future<void> scrollSeriePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byType(SingleChildScrollView);
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }

    /// expected
    expect(find.text('Now On Air'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
  }

  Future<void> clickSeeMoreOnAirSeries() async {
    final seePopularSeriesButtonFinder = find.byKey(
      const Key('btn_on_air_series'),
    );
    await tester.ensureVisible(seePopularSeriesButtonFinder);
    await tester.tap(seePopularSeriesButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeSeriesPage), findsNothing);
    expect(find.byType(OnAirSeriesPage), findsOneWidget);
  }

  Future<void> clickSeeMorePopularSeries() async {
    final seePopularSeriesButtonFinder = find.byKey(
      const Key('btn_popular_series'),
    );
    await tester.ensureVisible(seePopularSeriesButtonFinder);
    await tester.tap(seePopularSeriesButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeSeriesPage), findsNothing);
    expect(find.byType(PopularSeriesPage), findsOneWidget);
  }

  Future<void> clickSeeMoreTopRatedSeries() async {
    final seeTopRatedSeriesButtonFinder =
        find.byKey(const Key('btn_top_rated_series'));
    await tester.ensureVisible(seeTopRatedSeriesButtonFinder);
    await tester.tap(seeTopRatedSeriesButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeSeriesPage), findsNothing);
    expect(find.byType(TopRatedSeriesPage), findsOneWidget);
  }

  Future<void> clickSeriesItem({required String keyList}) async {
    final seriesItemFinder = find.byKey(Key(keyList));
    await tester.ensureVisible(seriesItemFinder);
    await tester.tap(seriesItemFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeSeriesPage), findsNothing);
    expect(find.byType(SeriesDetailPage), findsOneWidget);
  }

  Future<void> clickSearchSeriesButton() async {
    final searchButtonSeriesFinder = find.byIcon(Icons.search);
    await tester.ensureVisible(searchButtonSeriesFinder);
    await tester.tap(searchButtonSeriesFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeSeriesPage), findsNothing);
    expect(find.byType(SearchSeriesPage), findsOneWidget);
  }
}
