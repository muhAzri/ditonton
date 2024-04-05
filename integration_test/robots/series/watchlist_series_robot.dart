import 'dart:io';

import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/pages/pages.dart';

class WatchlistSeriesRobot {
  final WidgetTester tester;
  WatchlistSeriesRobot(this.tester);

  Future<void> switchToSeriesWatchlist() async {
    final tabFinder = find.text("Series");
    await tester.tap(tabFinder);
    await tester.pumpAndSettle();
  }

  Future<void> scrollWatchlistSeriesPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byType(ListView);
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.text('Watchlist'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byKey(const Key('watchlist_series_item_0')), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickSeriesItemWatchlist() async {
    final seriesItemFinder = find.byKey(const Key('watchlist_series_item_0'));
    await tester.ensureVisible(seriesItemFinder);
    await tester.tap(seriesItemFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(WatchlistPage), findsNothing);
    expect(find.byType(SeriesDetailPage), findsOneWidget);
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));

    /// expected
    expect(find.byType(WatchlistPage), findsNothing);
    expect(find.byType(HomeSeriesPage), findsOneWidget);
  }
}
