import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:movie/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchMovieBloc extends Mock implements SearchMovieBloc {
  MockSearchMovieBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockSearchMovieBloc mockSearchMovieBloc;
  late GetIt getIt;

  setUp(() {
    mockSearchMovieBloc = MockSearchMovieBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<SearchMovieBloc>(mockSearchMovieBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockSearchMovieBloc.close();
    getIt.reset();
  });

  group("Search Movie Page Test", () {
    testWidgets(
      "Search Movie Page Should Render List Of Movies When Bloc is Success",
      (tester) async {
        whenListen(
          getIt<SearchMovieBloc>(),
          Stream.fromIterable([
            SearchMovieInitial(),
            SearchMovieLoading(),
            SearchMovieLoaded(testMovieList)
          ]),
          initialState: SearchMovieInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              SearchPage(
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
      "Search Movie Page Should Render Circular Progress Indicator When Bloc is Loading",
      (tester) async {
        whenListen(
          getIt<SearchMovieBloc>(),
          Stream.fromIterable([
            SearchMovieInitial(),
            SearchMovieLoading(),
          ]),
          initialState: SearchMovieInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              SearchPage(
                locator: getIt,
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      "Search Movie Page Should Render Expanded With Key ('Empty State')  When Bloc is Failed",
      (tester) async {
        whenListen(
          getIt<SearchMovieBloc>(),
          Stream.fromIterable([
            SearchMovieInitial(),
            SearchMovieLoading(),
            const SearchMovieFailed("Error")
          ]),
          initialState: SearchMovieInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              SearchPage(
                locator: getIt,
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.byKey(const Key("Empty State")), findsOneWidget);
      },
    );
  });
}
