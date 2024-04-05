import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/on_air_series/on_air_series_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

import 'on_air_series_test.mocks.dart';

@GenerateMocks([GetOnAirSeries])
void main() {
  late MockGetOnAirSeries mockGetOnAirSeries;
  late OnAirSeriesBloc bloc;

  setUp(() {
    mockGetOnAirSeries = MockGetOnAirSeries();
    bloc = OnAirSeriesBloc(getOnAirSeries: mockGetOnAirSeries);
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

  group("Popular Movie Bloc Test", () {
    blocTest(
      "should Emit[OnAirSeriesLoading, OnAirSeriesLoaded] Data When usecases is success",
      build: () {
        when(mockGetOnAirSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchOnAirSeriesEvent()),
      expect: () => [
        OnAirSeriesLoading(),
        OnAirSeriesLoaded(series: tSeriesList),
      ],
    );

    blocTest(
      "should Emit[OnAirSeriesLoading, OnAirSeriesFailed] Data When usecases is failed",
      build: () {
        when(mockGetOnAirSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchOnAirSeriesEvent()),
      expect: () => [
        OnAirSeriesLoading(),
        const OnAirSeriesFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[OnAirSeriesLoading, OnAirSeriesFailed] Data When Exception Occurs",
      build: () {
        when(mockGetOnAirSeries.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchOnAirSeriesEvent()),
      expect: () => [
        OnAirSeriesLoading(),
        const OnAirSeriesFailed(error: "Exception Occurs"),
      ],
    );
  });
}
