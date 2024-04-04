import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:series/bloc/series_detail/series_detail_bloc.dart';
import 'package:series/presentation/pages/series_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSeriesDetailBloc extends Mock implements SeriesDetailBloc {
  MockSeriesDetailBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockSeriesDetailBloc mockSeriesDetailBloc;
  late GetIt getIt;

  setUp(() {
    mockSeriesDetailBloc = MockSeriesDetailBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<SeriesDetailBloc>(mockSeriesDetailBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockSeriesDetailBloc.close();
    getIt.reset();
  });

  testWidgets(
      'Watchlist button should display add icon when series not added to watchlist',
      (WidgetTester tester) async {
    whenListen(
        getIt<SeriesDetailBloc>(),
        Stream.fromIterable([
          SeriesDetailInitial(),
          SeriesDetailLoading(),
          const SeriesDetailLoaded(seriesDetail: testSeriesDetail),
        ]),
        initialState: SeriesDetailInitial());

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          SeriesDetailPage(
            id: 1,
            locator: getIt,
          ),
        ),
      ),
    );

    await tester.pump();

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when series is added to wathclist',
      (WidgetTester tester) async {
    whenListen(
      getIt<SeriesDetailBloc>(),
      Stream.fromIterable([
        SeriesDetailInitial(),
        SeriesDetailLoading(),
        const WatchlistStatusLoaded(true),
      ]),
      initialState: SeriesDetailInitial(),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<SeriesDetailBloc>(
            create: (_) => getIt<SeriesDetailBloc>(),
            child: DetailContent(
              testSeriesDetail,
              locator: getIt,
            ),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
      getIt<SeriesDetailBloc>(),
      Stream.fromIterable([
        SeriesDetailInitial(),
        SeriesDetailLoading(),
        const WatchlistChangeSuccess(message: "Added to Watchlist"),
      ]),
      initialState: SeriesDetailInitial(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<SeriesDetailBloc>(
            create: (_) => getIt<SeriesDetailBloc>(),
            child: Scaffold(
              body: DetailContent(
                testSeriesDetail,
                locator: getIt,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.pump();
    await tester.tap(watchlistButton, warnIfMissed: false);

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    whenListen(
      getIt<SeriesDetailBloc>(),
      Stream.fromIterable([
        SeriesDetailInitial(),
        SeriesDetailLoading(),
        const WatchlistChangeSuccess(message: "Removed from Watchlist"),
      ]),
      initialState: SeriesDetailInitial(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<SeriesDetailBloc>(
            create: (_) => getIt<SeriesDetailBloc>(),
            child: Scaffold(
              body: DetailContent(
                testSeriesDetail,
                locator: getIt,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.pump();
    await tester.tap(watchlistButton, warnIfMissed: false);

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
      getIt<SeriesDetailBloc>(),
      Stream.fromIterable([
        SeriesDetailInitial(),
        SeriesDetailLoading(),
        const WatchlistChangeSuccess(message: "Failed"),
      ]),
      initialState: SeriesDetailInitial(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<SeriesDetailBloc>(
            create: (_) => getIt<SeriesDetailBloc>(),
            child: Scaffold(
              body: DetailContent(
                testSeriesDetail,
                locator: getIt,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.pump();
    await tester.tap(watchlistButton, warnIfMissed: false);

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Render Recommendation Series Horizontal List when Success',
      (WidgetTester tester) async {
    whenListen(
      getIt<SeriesDetailBloc>(),
      Stream.fromIterable([
        SeriesDetailInitial(),
        SeriesDetailLoading(),
        SeriesRecommendationLoaded(recommendationSeries: testSeriesList),
      ]),
      initialState: SeriesDetailInitial(),
    );

    const tId = 1;

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<SeriesDetailBloc>(
            create: (_) => getIt<SeriesDetailBloc>(),
            child: Scaffold(
              body: RecommendationSection(
                seriesId: tId,
                locator: getIt,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(
        find.byType(CachedNetworkImage), findsNWidgets(testSeriesList.length));
  });

  testWidgets("Render Season Information As ListView", (tester) async {
    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          const SeriesSeasons(
            serie: testSeriesDetail,
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(
        find.byType(CachedNetworkImage), findsNWidgets(testSeriesList.length));

  });
}
