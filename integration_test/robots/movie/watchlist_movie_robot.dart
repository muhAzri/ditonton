import 'dart:io';

import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

class WatchlistMovieRobot {
  final WidgetTester tester;
  WatchlistMovieRobot(this.tester);

  Future<void> scrollWatchlistMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byType(ListView);
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.text('Watchlist'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byKey(const Key('watchlist_movie_item_0')), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickMovieItemWatchlist() async {
    final movieItemFinder = find.byKey(const Key('watchlist_movie_item_0'));
    await tester.ensureVisible(movieItemFinder);
    await tester.tap(movieItemFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(WatchlistPage), findsNothing);
    expect(find.byType(MovieDetailPage), findsOneWidget);
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));

    /// expected
    expect(find.byType(WatchlistPage), findsNothing);
    expect(find.byType(HomeMoviePage), findsOneWidget);
  }
}
