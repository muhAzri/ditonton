import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movie/bloc/home_movie/home_movie_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockHomeMovieBloc extends Mock implements HomeMovieBloc {
  MockHomeMovieBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockHomeMovieBloc mockHomeMovieBloc;
  late GetIt getIt;

  setUp(() {
    mockHomeMovieBloc = MockHomeMovieBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<HomeMovieBloc>(mockHomeMovieBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockHomeMovieBloc.close();
    getIt.reset();
  });

  testWidgets(
      'HomeMoviePage should render NowPlaying, Popular, and Top Rated Movie Sections',
      (WidgetTester tester) async {
    whenListen(
        getIt<HomeMovieBloc>(),
        Stream.fromIterable(
          [
            HomeMovieInitial(),
          ],
        ),
        initialState: HomeMovieInitial());

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          HomeMoviePage(
            locator: getIt,
          ),
        ),
      ),
    );

    await tester.pump();

    final nowPlayingSection = find.byType(NowPlayingMovieSection);
    final popularSection = find.byType(PopularMovieSection);
    final topRatedSection = find.byType(TopRatedMovieSection);

    expect(find.text("Now Playing"), findsOne);
    expect(nowPlayingSection, findsOneWidget);

    expect(find.text("Popular"), findsOne);
    expect(popularSection, findsOneWidget);

    expect(find.text("Top Rated"), findsOne);
    expect(topRatedSection, findsOneWidget);
  });

  group("Now Playing Movie Section", () {
    testWidgets(
        'NowPlayingMovieSection should render MovieList when Bloc Is Succes',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeMovieBloc>(),
          Stream.fromIterable(
            [
              HomeMovieInitial(),
              HomeMovieLoading(),
              NowPlayingMoviesLoaded(nowPlayingMovies: testMovieList)
            ],
          ),
          initialState: HomeMovieInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: NowPlayingMovieSection(
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
          testMovieList.length,
        ),
      );
    });

    testWidgets(
        'NowPlayingMovieSection should render CircularProgress Indicator when Bloc Is Loading',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeMovieBloc>(),
          Stream.fromIterable(
            [
              HomeMovieInitial(),
              HomeMovieLoading(),
            ],
          ),
          initialState: HomeMovieInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: NowPlayingMovieSection(
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
        'NowPlayingMovieSection should render Error Text when Bloc Is Failed',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeMovieBloc>(),
          Stream.fromIterable(
            [
              HomeMovieInitial(),
              HomeMovieLoading(),
              const HomeMovieFailed(error: "Error Occured")
            ],
          ),
          initialState: HomeMovieInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: NowPlayingMovieSection(
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

  group("Popular Movie Section", () {
    testWidgets(
        'PopularMovieSection should render MovieList when Bloc Is Succes',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeMovieBloc>(),
          Stream.fromIterable(
            [
              HomeMovieInitial(),
              HomeMovieLoading(),
              PopularMoviesLoaded(popularMovies: testMovieList)
            ],
          ),
          initialState: HomeMovieInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: PopularMovieSection(
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
          testMovieList.length,
        ),
      );
    });

    testWidgets(
        'PopularMovieSection should render CircularProgress Indicator when Bloc Is Loading',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeMovieBloc>(),
          Stream.fromIterable(
            [
              HomeMovieInitial(),
              HomeMovieLoading(),
            ],
          ),
          initialState: HomeMovieInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: PopularMovieSection(
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
        'PopularMovieSection should render Error Text when Bloc Is Failed',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeMovieBloc>(),
          Stream.fromIterable(
            [
              HomeMovieInitial(),
              HomeMovieLoading(),
              const HomeMovieFailed(error: "Error Occured")
            ],
          ),
          initialState: HomeMovieInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: PopularMovieSection(
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

  group("Top Rated Movie Section", () {
    testWidgets(
        'TopRatedMovieSection should render MovieList when Bloc Is Succes',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeMovieBloc>(),
          Stream.fromIterable(
            [
              HomeMovieInitial(),
              HomeMovieLoading(),
              TopRatedMoviesLoaded(topRatedMovies: testMovieList)
            ],
          ),
          initialState: HomeMovieInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: TopRatedMovieSection(
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
          testMovieList.length,
        ),
      );
    });

    testWidgets(
        'TopRatedMovieSection should render CircularProgress Indicator when Bloc Is Loading',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeMovieBloc>(),
          Stream.fromIterable(
            [
              HomeMovieInitial(),
              HomeMovieLoading(),
            ],
          ),
          initialState: HomeMovieInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: TopRatedMovieSection(
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
        'TopRatedMovieSection should render Error Text when Bloc Is Failed',
        (WidgetTester tester) async {
      whenListen(
          getIt<HomeMovieBloc>(),
          Stream.fromIterable(
            [
              HomeMovieInitial(),
              HomeMovieLoading(),
              const HomeMovieFailed(error: "Error Occured")
            ],
          ),
          initialState: HomeMovieInitial());

      await mockNetworkImages(
        () async => await tester.pumpWidget(
          makeTestableWidget(
            Material(
              child: TopRatedMovieSection(
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
      "Test Tap Movies To Close The Drawer",
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

        final homeButton = find.text("Movies");
        expect(homeButton, findsOne);

        await tester.tap(homeButton);
        await tester.pump();

        expect(find.text("Home"), findsOne);
      },
    );

    testWidgets(
      "Test Tap Movies To Navigate to Home Series",
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

        final homeButton = find.text("TV Series");
        expect(homeButton, findsOne);

        await tester.tap(homeButton);
        await tester.pumpAndSettle();

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
