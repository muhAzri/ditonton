import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

import 'top_rated_series_test.mocks.dart';

@GenerateMocks([GetTopRatedSeries])
void main() {
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late TopRatedSeriesBloc bloc;

  setUp(() {
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    bloc = TopRatedSeriesBloc(getTopRatedSeries: mockGetTopRatedSeries);
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
      "should Emit[TopRatedSeriesLoading, TopRatedSeriesLoaded] Data When usecases is success",
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => Right(tSeriesList));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
      expect: () => [
        TopRatedSeriesLoading(),
        TopRatedSeriesLoaded(series: tSeriesList),
      ],
    );

    blocTest(
      "should Emit[TopRatedSeriesLoading, TopRatedSeriesFailed] Data When usecases is failed",
      build: () {
        when(mockGetTopRatedSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
      expect: () => [
        TopRatedSeriesLoading(),
        const TopRatedSeriesFailed(error: "Failed"),
      ],
    );

    blocTest(
      "should Emit[TopRatedSeriesLoading, TopRatedSeriesFailed] Data When Exception Occurs",
      build: () {
        when(mockGetTopRatedSeries.execute()).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedSeriesEvent()),
      expect: () => [
        TopRatedSeriesLoading(),
        const TopRatedSeriesFailed(error: "Exception Occurs"),
      ],
    );
  });
}
