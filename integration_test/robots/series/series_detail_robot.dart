import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/pages/pages.dart';

class SeriesDetailRobot {
  final WidgetTester tester;
  SeriesDetailRobot(this.tester);

  Future<void> scrollDetailSeriesPage({bool scrollUp = false}) async {
    final scrollViewFinder =
        find.byKey(const Key("series_detail_scrollable_container"));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      /// expected
      expect(find.byType(DetailContent), findsOneWidget);
      expect(find.byType(DraggableScrollableSheet), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> scrollRecomendationSeriesPage({
    bool scrollBack = false,
  }) async {
    final scrollViewFinder =
        find.byKey(const Key("recommendation_series_list"));
    if (scrollBack) {
      await tester.fling(scrollViewFinder, const Offset(1000, 0), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(
        find.byKey(const Key("recommendation_series_list")),
        findsOneWidget,
      );
    } else {
      await tester.fling(scrollViewFinder, const Offset(-1000, 0), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickSeriesAddToWatchlistButton() async {
    final seriesWatchlistButtonFinder = find.byType(ElevatedButton);
    await tester.ensureVisible(seriesWatchlistButtonFinder);
    await tester.tap(seriesWatchlistButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byIcon(Icons.add), findsNothing);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  }

  Future<void> clickSeriesRemoveFromWatchlistButton() async {
    final seriesWatchlistButtonFinder = find.byType(ElevatedButton);
    await tester.ensureVisible(seriesWatchlistButtonFinder);
    await tester.tap(seriesWatchlistButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byIcon(Icons.check), findsNothing);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  }

  Future<void> goBack() async {
    final backButtonFinder = find.byIcon(Icons.arrow_back);
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeSeriesPage), findsOneWidget);
    expect(find.byType(SeriesDetailPage), findsNothing);
  }

  Future<void> goBackToWatchlist() async {
    final backButtonFinder = find.byIcon(Icons.arrow_back);
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(WatchlistPage), findsOneWidget);
    expect(find.byType(SeriesDetailPage), findsNothing);
    expect(find.byIcon(Icons.tv), findsOneWidget);
    expect(find.text('No series in your watchlist.'), findsOneWidget);
  }
}
