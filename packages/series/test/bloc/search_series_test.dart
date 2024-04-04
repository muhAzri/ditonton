import 'package:bloc_test/bloc_test.dart';
import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/bloc/search_series/search_series_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

import 'search_series_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SearchSeriesBloc bloc;
  late MockSearchSeries mockSearchSeries;

  setUp(() {
    mockSearchSeries = MockSearchSeries();
    bloc = SearchSeriesBloc(searchSeries: mockSearchSeries);
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
  const tQuery = 'breaking bad';

  group("Series search Bloc Test", () {
    blocTest(
      "should Emit[SearchSeriesLoading, SearchSeriesLoaded] Data When usecases is success",
      build: () {
        when(mockSearchSeries.execute(any))
            .thenAnswer((_) async => Right(tSeriesList));

        return bloc;
      },
      act: (bloc) => bloc.add(const SearchEvent(tQuery)),
      expect: () => [
        SearchSeriesLoading(),
        SearchSeriesLoaded(tSeriesList),
      ],
    );

    blocTest(
      "should Emit[SearchSeriesLoading, SearchSeriesFailed] Data When usecases is failed",
      build: () {
        when(mockSearchSeries.execute(any))
            .thenAnswer((_) async => const Left(ServerFailure("Failed")));

        return bloc;
      },
      act: (bloc) => bloc.add(const SearchEvent(tQuery)),
      expect: () => [
        SearchSeriesLoading(),
        const SearchSeriesFailed("Failed"),
      ],
    );

    blocTest(
      "should Emit[SearchSeriesLoading, SearchSeriesFailed] Data When Exception Occurs",
      build: () {
        when(mockSearchSeries.execute(any)).thenThrow("Exception Occurs");

        return bloc;
      },
      act: (bloc) => bloc.add(const SearchEvent(tQuery)),
      expect: () => [
        SearchSeriesLoading(),
        const SearchSeriesFailed("Exception Occurs"),
      ],
    );
  });
}
