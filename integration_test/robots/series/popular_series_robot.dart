import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:series/presentation/pages/pages.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class PopularSeriesRobot {
  final WidgetTester tester;
  PopularSeriesRobot(this.tester);

  Future<void> scrollPopularSeriesPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byType(ListView);
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.byType(SeriesCard), findsWidgets);
      expect(find.byKey(const Key('popular_series_item_0')), findsOneWidget);
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
    expect(find.byType(HomeSeriesPage), findsOneWidget);
    expect(find.byType(PopularSeriesPage), findsNothing);
  }
}
