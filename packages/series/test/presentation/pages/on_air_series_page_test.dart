import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:series/bloc/on_air_series/on_air_series_bloc.dart';
import 'package:series/presentation/pages/on_air_series_page.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockOnAirSeriesBloc extends Mock implements OnAirSeriesBloc {
  MockOnAirSeriesBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockOnAirSeriesBloc mockOnAirSeriesBloc;
  late GetIt getIt;

  setUp(() {
    mockOnAirSeriesBloc = MockOnAirSeriesBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<OnAirSeriesBloc>(mockOnAirSeriesBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockOnAirSeriesBloc.close();
    getIt.reset();
  });

  group("On Air Series Page Test", () {
    testWidgets(
      "On Air Series Page Should Render List Of Seriess When Bloc is Success",
      (tester) async {
        whenListen(
          getIt<OnAirSeriesBloc>(),
          Stream.fromIterable([
            OnAirSeriesInitial(),
            OnAirSeriesLoading(),
            OnAirSeriesLoaded(series: testSeriesList)
          ]),
          initialState: OnAirSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              OnAirSeriesPage(
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
      "On Air Series Page Should Render Error Text When Bloc is Error",
      (tester) async {
        whenListen(
          getIt<OnAirSeriesBloc>(),
          Stream.fromIterable([
            OnAirSeriesInitial(),
            OnAirSeriesLoading(),
            const OnAirSeriesFailed(error: "Error Occured")
          ]),
          initialState: OnAirSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              OnAirSeriesPage(
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
      "On Air Series Page Should Render Circular Progress Indicator When Bloc is Loading",
      (tester) async {
        whenListen(
          getIt<OnAirSeriesBloc>(),
          Stream.fromIterable([
            OnAirSeriesInitial(),
            OnAirSeriesLoading(),
          ]),
          initialState: OnAirSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              OnAirSeriesPage(
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
