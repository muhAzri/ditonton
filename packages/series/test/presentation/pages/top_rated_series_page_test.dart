import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:series/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedSeriesBloc extends Mock implements TopRatedSeriesBloc {
  MockTopRatedSeriesBloc() {
    when(() => close()).thenAnswer((_) async => {});
  }
}

void main() {
  late MockTopRatedSeriesBloc mockTopRatedSeriesBloc;
  late GetIt getIt;

  setUp(() {
    mockTopRatedSeriesBloc = MockTopRatedSeriesBloc();

    getIt = GetIt.instance;
    getIt.registerSingleton<TopRatedSeriesBloc>(mockTopRatedSeriesBloc);
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: body,
    );
  }

  tearDown(() {
    mockTopRatedSeriesBloc.close();
    getIt.reset();
  });

  group("TopRated Series Page Test", () {
    testWidgets(
      "TopRated Series Page Should Render List Of Seriess When Bloc is Success",
      (tester) async {
        whenListen(
          getIt<TopRatedSeriesBloc>(),
          Stream.fromIterable([
            TopRatedSeriesInitial(),
            TopRatedSeriesLoading(),
            TopRatedSeriesLoaded(series: testSeriesList)
          ]),
          initialState: TopRatedSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              TopRatedSeriesPage(
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
      "TopRated Series Page Should Render Error Text When Bloc is Error",
      (tester) async {
        whenListen(
          getIt<TopRatedSeriesBloc>(),
          Stream.fromIterable([
            TopRatedSeriesInitial(),
            TopRatedSeriesLoading(),
            const TopRatedSeriesFailed(error: "Error Occured")
          ]),
          initialState: TopRatedSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              TopRatedSeriesPage(
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
      "TopRated Series Page Should Render Circular Progress Indicator When Bloc is Loading",
      (tester) async {
        whenListen(
          getIt<TopRatedSeriesBloc>(),
          Stream.fromIterable([
            TopRatedSeriesInitial(),
            TopRatedSeriesLoading(),
          ]),
          initialState: TopRatedSeriesInitial(),
        );

        await mockNetworkImages(
          () async => await tester.pumpWidget(
            makeTestableWidget(
              TopRatedSeriesPage(
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
