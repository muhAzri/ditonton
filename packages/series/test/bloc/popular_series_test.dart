import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/popular_series.dart/popular_series_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

import 'popular_series_test.mocks.dart';

@GenerateMocks([GetPopularSeries])
void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late PopularSeriesBloc bloc;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    bloc = PopularSeriesBloc(getPopularSeries: mockGetPopularSeries);
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

  group("Popular Series Bloc Test", () {
    blocTest(
      "should Emit[PopularSeriesLoading, PopularSeriesLoaded] Data When usecases is success",
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeriesEvent()),
      expect: () => [
        PopularSeriesLoading(),
        PopularSeriesLoaded(series: tSeriesList),
      ],
    );

    blocTest(
      "should Emit[PopularSeriesLoading, PopularSeriesFailed] Data When usecases is failed",
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeriesEvent()),
      expect: () => [
        PopularSeriesLoading(),
        const PopularSeriesFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[PopularSeriesLoading, PopularSeriesFailed] Data When Exception Occurs",
      build: () {
        when(mockGetPopularSeries.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeriesEvent()),
      expect: () => [
        PopularSeriesLoading(),
        const PopularSeriesFailed(error: "Exception Occurs"),
      ],
    );
  });
}
