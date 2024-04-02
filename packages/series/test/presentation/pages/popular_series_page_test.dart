import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/pages/pages.dart';
import 'package:series/presentation/provider/provider.dart';

import 'popular_series_page_test.mocks.dart';

@GenerateMocks([PopularSeriesNotifier])
void main() {
  late MockPopularSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPopularSeriesNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularSeriesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.series).thenReturn(<Series>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
