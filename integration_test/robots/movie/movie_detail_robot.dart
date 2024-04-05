import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/pages/pages.dart';

class MovieDetailRobot {
  final WidgetTester tester;
  MovieDetailRobot(this.tester);

  Future<void> scrollDetailMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder =
        find.byKey(const Key("movie_detail_scrollable_container"));
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

  Future<void> scrollRecomendationMovieDetailPage({
    bool scrollBack = false,
  }) async {
    final scrollViewFinder = find.byType(ListView);
    if (scrollBack) {
      await tester.fling(scrollViewFinder, const Offset(1000, 0), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(
        find.byType(ListView),
        findsOneWidget,
      );
    } else {
      await tester.fling(scrollViewFinder, const Offset(-1000, 0), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickMovieAddToWatchlistButton() async {
    final movieWatchlistButtonFinder = find.byType(ElevatedButton);
    await tester.ensureVisible(movieWatchlistButtonFinder);
    await tester.tap(movieWatchlistButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byIcon(Icons.add), findsNothing);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  }

  Future<void> clickMovieRemoveFromWatchlistButton() async {
    final movieWatchlistButtonFinder = find.byType(ElevatedButton);
    await tester.ensureVisible(movieWatchlistButtonFinder);
    await tester.tap(movieWatchlistButtonFinder);
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
    expect(find.byType(HomeMoviePage), findsOneWidget);
    expect(find.byType(MovieDetailPage), findsNothing);
  }

  Future<void> goBackToWatchlist() async {
    final backButtonFinder = find.byIcon(Icons.arrow_back);
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(WatchlistPage), findsOneWidget);
    expect(find.byType(MovieDetailPage), findsNothing);
    expect(find.byIcon(Icons.movie_creation), findsOneWidget);
    expect(find.text('No movies in your watchlist.'), findsOneWidget);
  }
}
