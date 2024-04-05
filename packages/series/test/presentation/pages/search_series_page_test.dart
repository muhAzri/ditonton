import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:series/bloc/search_series/search_series_bloc.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchSeriesBloc extends Mock implements SearchSeriesBloc {
  MockSearchSeriesBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockSearchSeriesBloc mockSearchSeriesBloc;
  late GetIt getIt;

  setUp(() {
    mockSearchSeriesBloc = MockSearchSeriesBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<SearchSeriesBloc>(mockSearchSeriesBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockSearchSeriesBloc.close();
    getIt.reset();
  });

  group("Search Series Page Test", () {
    testWidgets(
      "Search Series Page Should Render List Of Seriess When Bloc is Success",
      (tester) async {
        whenListen(
          getIt<SearchSeriesBloc>(),
          Stream.fromIterable([
            SearchSeriesInitial(),
            SearchSeriesLoading(),
            SearchSeriesLoaded(testSeriesList)
          ]),
          initialState: SearchSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              SearchSeriesPage(
                locator: getIt,
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(SeriesCard), findsNWidgets(testSeriesList.length));
      },
    );

    testWidgets(
      "Search Series Page Should Render Circular Progress Indicator When Bloc is Loading",
      (tester) async {
        whenListen(
          getIt<SearchSeriesBloc>(),
          Stream.fromIterable([
            SearchSeriesInitial(),
            SearchSeriesLoading(),
          ]),
          initialState: SearchSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              SearchSeriesPage(
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
      "Search Series Page Should Render Expanded With Key ('Empty State')  When Bloc is Failed",
      (tester) async {
        whenListen(
          getIt<SearchSeriesBloc>(),
          Stream.fromIterable([
            SearchSeriesInitial(),
            SearchSeriesLoading(),
            const SearchSeriesFailed("Error")
          ]),
          initialState: SearchSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              SearchSeriesPage(
                locator: getIt,
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.byKey(const Key("Empty State")), findsOneWidget);
      },
    );
    testWidgets(
      "Search Series Page Should Trigger Search Event When TextForm is Submitted",
      (tester) async {
        whenListen(
          getIt<SearchSeriesBloc>(),
          Stream.fromIterable([
            SearchSeriesInitial(),
          ]),
          initialState: SearchSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              SearchSeriesPage(
                locator: getIt,
              ),
            ),
          ),
        );

        await tester.pump();

        // Find the TextFormField
        final textFieldFinder = find.byType(TextField);

        // Enter text into the TextFormField
        await tester.enterText(textFieldFinder, 'search query');

        // Submit the form
        await tester.testTextInput.receiveAction(TextInputAction.done);

        // Ensure that the SearchEvent is added to the bloc
        verify(() =>
                mockSearchSeriesBloc.add(const SearchEvent('search query')))
            .called(1);
      },
    );
  });
}
