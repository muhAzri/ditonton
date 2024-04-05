import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movie/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMovieBloc extends Mock implements PopularMovieBloc {
  MockPopularMovieBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;
  late GetIt getIt;

  setUp(() {
    mockPopularMovieBloc = MockPopularMovieBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<PopularMovieBloc>(mockPopularMovieBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockPopularMovieBloc.close();
    getIt.reset();
  });

  group("Popular Movie Page Test", () {
    testWidgets(
      "Popular Movie Page Should Render List Of Movies When Bloc is Success",
      (tester) async {
        whenListen(
          getIt<PopularMovieBloc>(),
          Stream.fromIterable([
            PopularMovieInitial(),
            PopularMovieLoading(),
            PopularMovieLoaded(movies: testMovieList)
          ]),
          initialState: PopularMovieInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              PopularMoviesPage(
                locator: getIt,
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(MovieCard), findsNWidgets(testMovieList.length));
      },
    );

    testWidgets(
      "Popular Movie Page Should Render Error Text When Bloc is Error",
      (tester) async {
        whenListen(
          getIt<PopularMovieBloc>(),
          Stream.fromIterable([
            PopularMovieInitial(),
            PopularMovieLoading(),
            const PopularMovieFailed(error: "Error Occured")
          ]),
          initialState: PopularMovieInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              PopularMoviesPage(
                locator: getIt,
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.text("Error Occured"), findsOne);
      },
    );

    testWidgets(
      "Popular Movie Page Should Render Circular Progress Indicator When Bloc is Loading",
      (tester) async {
        whenListen(
          getIt<PopularMovieBloc>(),
          Stream.fromIterable([
            PopularMovieInitial(),
            PopularMovieLoading(),
          ]),
          initialState: PopularMovieInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              PopularMoviesPage(
                locator: getIt,
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );
  });
}
