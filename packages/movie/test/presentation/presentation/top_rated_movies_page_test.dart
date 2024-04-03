import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movie/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/presentation/pages/pages.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedMovieBloc extends Mock implements TopRatedMovieBloc {
  MockTopRatedMovieBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockTopRatedMovieBloc mockTopRatedMovieBloc;
  late GetIt getIt;

  setUp(() {
    mockTopRatedMovieBloc = MockTopRatedMovieBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<TopRatedMovieBloc>(mockTopRatedMovieBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockTopRatedMovieBloc.close();
    getIt.reset();
  });

  group("Top Rated Movie Page Test", () {
    testWidgets(
      "Top Rated Movie Page Should Render List Of Movies When Bloc is Success",
      (tester) async {
        whenListen(
          getIt<TopRatedMovieBloc>(),
          Stream.fromIterable([
            TopRatedMovieInitial(),
            TopRatedMovieLoading(),
            TopRatedMovieLoaded(movies: testMovieList)
          ]),
          initialState: TopRatedMovieInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              TopRatedMoviesPage(
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
      "Top Rated Movie Page Should Render Error Text When Bloc is Error",
      (tester) async {
        whenListen(
          getIt<TopRatedMovieBloc>(),
          Stream.fromIterable([
            TopRatedMovieInitial(),
            TopRatedMovieLoading(),
            const TopRatedMovieFailed(error: "Error Occured")
          ]),
          initialState: TopRatedMovieInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              TopRatedMoviesPage(
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
      "Top Rated Movie Page Should Render Circular Progress Indicator When Bloc is Loading",
      (tester) async {
        whenListen(
          getIt<TopRatedMovieBloc>(),
          Stream.fromIterable([
            TopRatedMovieInitial(),
            TopRatedMovieLoading(),
          ]),
          initialState: TopRatedMovieInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              TopRatedMoviesPage(
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
