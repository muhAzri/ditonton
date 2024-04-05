import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/pages/pages.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

class PopularMovieRobot {
  final WidgetTester tester;
  PopularMovieRobot(this.tester);

  Future<void> scrollPopularMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byType(ListView);
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.byType(MovieCard), findsWidgets);
      expect(find.byKey(const Key('popular_movie_item_0')), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));

    /// expected
    expect(find.byType(HomeMoviePage), findsOneWidget);
    expect(find.byType(PopularMoviesPage), findsNothing);
  }
}
