import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:series/bloc/home_series/home_series_bloc.dart';
import 'package:series/presentation/pages/home_series_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockHomeSeriesBloc extends Mock implements HomeSeriesBloc {
  MockHomeSeriesBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockHomeSeriesBloc mockHomeSeriesBloc;
  late GetIt getIt;

  setUp(() {
    mockHomeSeriesBloc = MockHomeSeriesBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<HomeSeriesBloc>(mockHomeSeriesBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockHomeSeriesBloc.close();
    getIt.reset();
  });

  testWidgets(
      'HomeSeriesPage should render OnAir, Popular, and Top Rated Series Sections',
      (WidgetTester tester) async {
    whenListen(
        getIt<HomeSeriesBloc>(),
        Stream.fromIterable(
          [
            HomeSeriesInitial(),
          ],
        ),
        initialState: HomeSeriesInitial());

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          HomeSeriesPage(
            locator: getIt,
          ),
        ),
      ),
    );

    await tester.pump();

    final onAirSeriesSection = find.byType(OnAirSeriesSection);
    final popularSection = find.byType(PopularSeriesSection);
    final topRatedSection = find.byType(TopRatedSeriesSection);

    expect(find.text("Now On Air"), findsOne);
    expect(onAirSeriesSection, findsOneWidget);

    expect(find.text("Popular"), findsOne);
    expect(popularSection, findsOneWidget);

    expect(find.text("Top Rated"), findsOne);
    expect(topRatedSection, findsOneWidget);
  });

  group("Now Playing Series Section", () {
    testWidgets(
        'OnAirSeriesSection should render SeriesList when Bloc Is Succes',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeSeriesBloc>(),
          Stream.fromIterable(
            [
              HomeSeriesInitial(),
              HomeSeriesLoading(),
              OnAirSeriesLoaded(onAirSeries: testSeriesList)
            ],
          ),
          initialState: HomeSeriesInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: OnAirSeriesSection(
                locator: getIt,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(
        find.byType(CachedNetworkImage),
        findsNWidgets(
          testSeriesList.length,
        ),
      );
    });

    testWidgets(
        'OnAirSeriesSection should render CircularProgress Indicator when Bloc Is Loading',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeSeriesBloc>(),
          Stream.fromIterable(
            [
              HomeSeriesInitial(),
              HomeSeriesLoading(),
            ],
          ),
          initialState: HomeSeriesInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: OnAirSeriesSection(
                locator: getIt,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'OnAirSeriesSection should render Error Text when Bloc Is Failed',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeSeriesBloc>(),
          Stream.fromIterable(
            [
              HomeSeriesInitial(),
              HomeSeriesLoading(),
              const HomeSeriesFailed(error: "Error Occured")
            ],
          ),
          initialState: HomeSeriesInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: OnAirSeriesSection(
                locator: getIt,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text("Error Occured"), findsOne);
    });
  });

  group("Popular Series Section", () {
    testWidgets(
        'PopularSeriesSection should render SeriesList when Bloc Is Succes',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeSeriesBloc>(),
          Stream.fromIterable(
            [
              HomeSeriesInitial(),
              HomeSeriesLoading(),
              PopularSeriesLoaded(popularSeries: testSeriesList)
            ],
          ),
          initialState: HomeSeriesInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: PopularSeriesSection(
                locator: getIt,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(
        find.byType(CachedNetworkImage),
        findsNWidgets(
          testSeriesList.length,
        ),
      );
    });

    testWidgets(
        'PopularSeriesSection should render CircularProgress Indicator when Bloc Is Loading',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeSeriesBloc>(),
          Stream.fromIterable(
            [
              HomeSeriesInitial(),
              HomeSeriesLoading(),
            ],
          ),
          initialState: HomeSeriesInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: PopularSeriesSection(
                locator: getIt,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'PopularSeriesSection should render Error Text when Bloc Is Failed',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeSeriesBloc>(),
          Stream.fromIterable(
            [
              HomeSeriesInitial(),
              HomeSeriesLoading(),
              const HomeSeriesFailed(error: "Error Occured")
            ],
          ),
          initialState: HomeSeriesInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: PopularSeriesSection(
                locator: getIt,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text("Error Occured"), findsOne);
    });
  });

  group("Top Rated Series Section", () {
    testWidgets(
        'TopRatedSeriesSection should render SeriesList when Bloc Is Succes',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeSeriesBloc>(),
          Stream.fromIterable(
            [
              HomeSeriesInitial(),
              HomeSeriesLoading(),
              TopRatedSeriesLoaded(topRatedSeries: testSeriesList)
            ],
          ),
          initialState: HomeSeriesInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: TopRatedSeriesSection(
                locator: getIt,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(
        find.byType(CachedNetworkImage),
        findsNWidgets(
          testSeriesList.length,
        ),
      );
    });

    testWidgets(
        'TopRatedSeriesSection should render CircularProgress Indicator when Bloc Is Loading',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeSeriesBloc>(),
          Stream.fromIterable(
            [
              HomeSeriesInitial(),
              HomeSeriesLoading(),
            ],
          ),
          initialState: HomeSeriesInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: TopRatedSeriesSection(
                locator: getIt,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'TopRatedSeriesSection should render Error Text when Bloc Is Failed',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeSeriesBloc>(),
          Stream.fromIterable(
            [
              HomeSeriesInitial(),
              HomeSeriesLoading(),
              const HomeSeriesFailed(error: "Error Occured")
            ],
          ),
          initialState: HomeSeriesInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: TopRatedSeriesSection(
                locator: getIt,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text("Error Occured"), findsOne);
    });
  });

  group("Home Drawer Tests", () {
    testWidgets(
      "Home Drawer Render Smoothly",
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              "/": (context) => Scaffold(
                    drawer: const HomeDrawer(),
                    body: const Text("Home"),
                    appBar: AppBar(
                      title: const Text("App Bar"),
                    ),
                  ),
              "/home-series": (context) => const Text("Home Series"),
              "/watchlist": (context) => const Text("Watchlist"),
              "/about": (context) => const Text("About")
            },
          ),
        );

        await tester.pump();

        expect(find.byType(HomeDrawer), findsNothing);

        // Tap to open the drawer
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        expect(find.byType(HomeDrawer), findsOne);
        expect(find.text("Ditonton"), findsOne);
        expect(find.text("ditonton@dicoding.com"), findsOne);

        expect(
          find.byType(ListTile),
          findsNWidgets(4),
        );

        expect(find.text("Movies"), findsOne);
        expect(find.text("TV Series"), findsOne);
        expect(find.text("Watchlist"), findsOne);
        expect(find.text("About"), findsOne);
      },
    );

    testWidgets(
      "Test Tap Movie To Navigate to Home Movie",
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              "/": (context) => Scaffold(
                    drawer: const HomeDrawer(),
                    body: const Text("Home Series"),
                    appBar: AppBar(
                      title: const Text("App Bar"),
                    ),
                  ),
              "/home": (context) => const Text("Home"),
              "/watchlist": (context) => const Text("Watchlist"),
              "/about": (context) => const Text("About")
            },
          ),
        );

        await tester.pump();

        expect(find.byType(HomeDrawer), findsNothing);

        // Tap to open the drawer
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        final homeButton = find.text("Movies");
        expect(homeButton, findsOne);

        await tester.tap(homeButton);
        await tester.pumpAndSettle();

        expect(find.text("Home"), findsOne);
      },
    );

    testWidgets(
      "Test Tap TV Series To Close The Drawer",
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              "/": (context) => Scaffold(
                    drawer: const HomeDrawer(),
                    body: const Text("Home Series"),
                    appBar: AppBar(
                      title: const Text("App Bar"),
                    ),
                  ),
              "/home": (context) => const Text("Home"),
              "/watchlist": (context) => const Text("Watchlist"),
              "/about": (context) => const Text("About")
            },
          ),
        );

        await tester.pump();

        expect(find.byType(HomeDrawer), findsNothing);

        // Tap to open the drawer
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        final homeButton = find.text("TV Series");
        expect(homeButton, findsOne);

        await tester.tap(homeButton);
        await tester.pump();

        expect(find.text("Home Series"), findsOne);
      },
    );

    testWidgets(
      "Test Tap Movies To Navigate to Watchlist Pages",
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              "/": (context) => Scaffold(
                    drawer: const HomeDrawer(),
                    body: const Text("Home"),
                    appBar: AppBar(
                      title: const Text("App Bar"),
                    ),
                  ),
              "/home-series": (context) => const Text("Home Series"),
              "/watchlist": (context) => const Text("Watchlist"),
              "/about": (context) => const Text("About")
            },
          ),
        );

        await tester.pump();

        expect(find.byType(HomeDrawer), findsNothing);

        // Tap to open the drawer
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        final watchlistButton = find.text("Watchlist");
        expect(watchlistButton, findsOne);

        await tester.tap(watchlistButton);
        await tester.pumpAndSettle();

        expect(find.text("Watchlist"), findsOne);
      },
    );

    testWidgets(
      "Test Tap Movies To Navigate to About Page",
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            routes: {
              "/": (context) => Scaffold(
                    drawer: const HomeDrawer(),
                    body: const Text("Home"),
                    appBar: AppBar(
                      title: const Text("App Bar"),
                    ),
                  ),
              "/home-series": (context) => const Text("Home Series"),
              "/watchlist": (context) => const Text("Watchlist"),
              "/about": (context) => const Text("About")
            },
          ),
        );

        await tester.pump();

        expect(find.byType(HomeDrawer), findsNothing);

        // Tap to open the drawer
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        final aboutButton = find.text("About");
        expect(aboutButton, findsOne);

        await tester.tap(aboutButton);
        await tester.pumpAndSettle();

        expect(find.text("About"), findsOne);
      },
    );
  });
}
