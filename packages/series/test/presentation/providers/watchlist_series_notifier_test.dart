import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/usecases.dart';
import 'package:series/presentation/provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_series_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistSeries])
void main() {
  late WatchlistSeriesNotifier provider;
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    provider = WatchlistSeriesNotifier(
      getWatchlistSeries: mockGetWatchlistSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistSeries.execute())
        .thenAnswer((_) async => const Right([testWatchlistSeries]));
    // act
    await provider.fetchWatchlistSeries();
    // assert
    expect(provider.watchlistState, RequestState.loaded);
    expect(provider.watchlistSeries, [testWatchlistSeries]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistSeries.execute())
        .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistSeries();
    // assert
    expect(provider.watchlistState, RequestState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
