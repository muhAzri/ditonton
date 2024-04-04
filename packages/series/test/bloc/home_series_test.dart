import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/home_series/home_series_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

import 'home_series_test.mocks.dart';

@GenerateMocks([GetOnAirSeries, GetPopularSeries, GetTopRatedSeries])
void main() {
  late HomeSeriesBloc bloc;
  late MockGetOnAirSeries mockGetOnAirSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;

  setUp(() {
    mockGetOnAirSeries = MockGetOnAirSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    bloc = HomeSeriesBloc(
      getOnAirSeries: mockGetOnAirSeries,
      getPopularSeries: mockGetPopularSeries,
      getTopRatedSeries: mockGetTopRatedSeries,
    );
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

  group('onAir series', () {
    blocTest(
      "should Emit[HomeSeriesLoading, OnAirSeriesLoaded] Data When usecases is success",
      build: () {
        when(mockGetOnAirSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchOnAirSeriesEvent()),
      expect: () => [
        HomeSeriesLoading(),
        OnAirSeriesLoaded(onAirSeries: tSeriesList),
      ],
    );

    blocTest(
      "should Emit[HomeSeriesLoading, HomeSeriesFailed] Data When usecases is failed",
      build: () {
        when(mockGetOnAirSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchOnAirSeriesEvent()),
      expect: () => [
        HomeSeriesLoading(),
        const HomeSeriesFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[HomeSeriesLoading, HomeSeriesFailed] Data When Exception Occurs",
      build: () {
        when(mockGetOnAirSeries.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchOnAirSeriesEvent()),
      expect: () => [
        HomeSeriesLoading(),
        const HomeSeriesFailed(error: "Exception Occurs"),
      ],
    );
  });

  group('popular series', () {
    blocTest(
      "should Emit[HomeSeriesLoading, PopularSeriesLoaded] Data When usecases is success",
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeriesEvent()),
      expect: () => [
        HomeSeriesLoading(),
        PopularSeriesLoaded(popularSeries: tSeriesList),
      ],
    );

    blocTest(
      "should Emit[HomeSeriesLoading, HomeSeriesFailed] Data When usecases is failed",
      build: () {
        when(mockGetPopularSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeriesEvent()),
      expect: () => [
        HomeSeriesLoading(),
        const HomeSeriesFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[HomeSeriesLoading, HomeSeriesFailed] Data When Exception Occurs",
      build: () {
        when(mockGetPopularSeries.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchPopularSeriesEvent()),
      expect: () => [
        HomeSeriesLoading(),
        const HomeSeriesFailed(error: "Exception Occurs"),
      ],
    );
  });

  group('top rated series', () {
    blocTest(
      "should Emit[HomeSeriesLoading, TopRatedSeriesLoaded] Data When usecases is success",
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
      expect: () => [
        HomeSeriesLoading(),
        TopRatedSeriesLoaded(topRatedSeries: tSeriesList),
      ],
    );

    blocTest(
      "should Emit[HomeSeriesLoading, HomeSeriesFailed] Data When usecases is failed",
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
      expect: () => [
        HomeSeriesLoading(),
        const HomeSeriesFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[HomeSeriesLoading, HomeSeriesFailed] Data When Exception Occurs",
      build: () {
        when(mockGetTopRatedSeries.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
      expect: () => [
        HomeSeriesLoading(),
        const HomeSeriesFailed(error: "Exception Occurs"),
      ],
    );
  });
}
