import 'package:bloc_test/bloc_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movie/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends Mock implements MovieDetailBloc {
  MockMovieDetailBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late GetIt getIt;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<MovieDetailBloc>(mockMovieDetailBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockMovieDetailBloc.close();
    getIt.reset();
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    whenListen(
        getIt<MovieDetailBloc>(),
        Stream.fromIterable([
          MovieDetailInitial(),
          MovieDetailLoading(),
          const MovieDetailLoaded(movieDetail: testMovieDetail),
        ]),
        initialState: MovieDetailInitial());

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          MovieDetailPage(
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
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    whenListen(
      getIt<MovieDetailBloc>(),
      Stream.fromIterable([
        MovieDetailInitial(),
        MovieDetailLoading(),
        const WatchlistStatusLoaded(true),
      ]),
      initialState: MovieDetailInitial(),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<MovieDetailBloc>(
            create: (_) => getIt<MovieDetailBloc>(),
            child: DetailContent(
              testMovieDetail,
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
      getIt<MovieDetailBloc>(),
      Stream.fromIterable([
        MovieDetailInitial(),
        MovieDetailLoading(),
        const WatchlistChangeSuccess(message: "Added to Watchlist"),
      ]),
      initialState: MovieDetailInitial(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<MovieDetailBloc>(
            create: (_) => getIt<MovieDetailBloc>(),
            child: Scaffold(
              body: DetailContent(
                testMovieDetail,
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
      getIt<MovieDetailBloc>(),
      Stream.fromIterable([
        MovieDetailInitial(),
        MovieDetailLoading(),
        const WatchlistChangeSuccess(message: "Removed from Watchlist"),
      ]),
      initialState: MovieDetailInitial(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<MovieDetailBloc>(
            create: (_) => getIt<MovieDetailBloc>(),
            child: Scaffold(
              body: DetailContent(
                testMovieDetail,
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
      getIt<MovieDetailBloc>(),
      Stream.fromIterable([
        MovieDetailInitial(),
        MovieDetailLoading(),
        const WatchlistChangeSuccess(message: "Failed"),
      ]),
      initialState: MovieDetailInitial(),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<MovieDetailBloc>(
            create: (_) => getIt<MovieDetailBloc>(),
            child: Scaffold(
              body: DetailContent(
                testMovieDetail,
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

  testWidgets('Render Recommendation Movie Horizontal List when Success',
      (WidgetTester tester) async {
    whenListen(
      getIt<MovieDetailBloc>(),
      Stream.fromIterable([
        MovieDetailInitial(),
        MovieDetailLoading(),
        MovieRecommendationLoaded(recommendationMovies: testMovieList),
      ]),
      initialState: MovieDetailInitial(),
    );

    const tId = 1;

    await mockNetworkImages(
      () async => await tester.pumpWidget(
        makeTestableWidget(
          BlocProvider<MovieDetailBloc>(
            create: (_) => getIt<MovieDetailBloc>(),
            child: Scaffold(
              body: RecommendationSection(
                movieID: tId,
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
        find.byType(CachedNetworkImage), findsNWidgets(testMovieList.length));
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
