import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/watchlist_series/watchlist_series_bloc.dart';
import 'package:series/domain/usecases/usecases.dart';

import '../dummy_data/dummy_objects.dart';
import 'watchlist_series_test.mocks.dart';

@GenerateMocks([GetWatchlistSeries])
void main() {
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late WatchlistSeriesBloc bloc;

  setUp(() {
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    bloc = WatchlistSeriesBloc(getWatchlistSeries: mockGetWatchlistSeries);
  });

  group("Popular Series Bloc Test", () {
    blocTest(
      "should Emit[WatchlistSeriesLoading, WatchlistSeriesLoaded] Data When usecases is success",
      build: () {
        when(mockGetWatchlistSeries.execute())
            .thenAnswer((_) async => const Right([testWatchlistSeries]));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistSeriesEvents()),
      expect: () => [
        WatchlistSeriesLoading(),
        const WatchlistSeriesLoaded([testWatchlistSeries]),
      ],
    );

    blocTest(
      "should Emit[WatchlistSeriesLoading, WatchlistSeriesFailed] Data When usecases is failed",
      build: () {
        when(mockGetWatchlistSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistSeriesEvents()),
      expect: () => [
        WatchlistSeriesLoading(),
        const WatchlistSeriesFailed("Failed"),
      ],
    );

    blocTest(
      "should Emit[WatchlistSeriesLoading, WatchlistSeriesFailed] Data When Exception Occurs",
      build: () {
        when(mockGetWatchlistSeries.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchWatchlistSeriesEvents()),
      expect: () => [
        WatchlistSeriesLoading(),
        const WatchlistSeriesFailed("Exception Occurs"),
      ],
    );
  });
}
