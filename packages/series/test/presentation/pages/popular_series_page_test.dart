import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:series/bloc/popular_series.dart/popular_series_bloc.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularSeriesBloc extends Mock implements PopularSeriesBloc {
  MockPopularSeriesBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockPopularSeriesBloc mockPopularSeriesBloc;
  late GetIt getIt;

  setUp(() {
    mockPopularSeriesBloc = MockPopularSeriesBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<PopularSeriesBloc>(mockPopularSeriesBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockPopularSeriesBloc.close();
    getIt.reset();
  });

  group("Popular Series Page Test", () {
    testWidgets(
      "Popular Series Page Should Render List Of Seriess When Bloc is Success",
      (tester) async {
        whenListen(
          getIt<PopularSeriesBloc>(),
          Stream.fromIterable([
            PopularSeriesInitial(),
            PopularSeriesLoading(),
            PopularSeriesLoaded(series: testSeriesList)
          ]),
          initialState: PopularSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              PopularSeriesPage(
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
      "Popular Series Page Should Render Error Text When Bloc is Error",
      (tester) async {
        whenListen(
          getIt<PopularSeriesBloc>(),
          Stream.fromIterable([
            PopularSeriesInitial(),
            PopularSeriesLoading(),
            const PopularSeriesFailed(error: "Error Occured")
          ]),
          initialState: PopularSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              PopularSeriesPage(
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
      "Popular Series Page Should Render Circular Progress Indicator When Bloc is Loading",
      (tester) async {
        whenListen(
          getIt<PopularSeriesBloc>(),
          Stream.fromIterable([
            PopularSeriesInitial(),
            PopularSeriesLoading(),
          ]),
          initialState: PopularSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              PopularSeriesPage(
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
