import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:core/common/state_enum.dart';
import 'package:series/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/usecases.dart';
import 'package:series/presentation/provider/provider.dart';

import 'on_air_series_notifier_test.mocks.dart';

@GenerateMocks([GetOnAirSeries])
void main() {
  late MockGetOnAirSeries mockGetOnAirSeries;
  late OnAirSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirSeries = MockGetOnAirSeries();
    notifier = OnAirSeriesNotifier(getOnAirSeries: mockGetOnAirSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  const tSeries = Series(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );

  final tSeriesList = <Series>[tSeries];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetOnAirSeries.execute())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    notifier.fetchOnAirSeries();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change series data when data is gotten successfully', () async {
    // arrange
    when(mockGetOnAirSeries.execute())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    await notifier.fetchOnAirSeries();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.series, tSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetOnAirSeries.execute())
        .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchOnAirSeries();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
