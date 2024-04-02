import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/usecases/usecases.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveSeriesWatchlist usecase;
  late MockSeriesRepository mockSeriesRepository;

  setUp(() {
    mockSeriesRepository = MockSeriesRepository();
    usecase = RemoveSeriesWatchlist(mockSeriesRepository);
  });

  test('should remove watchlist series from repository', () async {
    // arrange
    when(mockSeriesRepository.removeWatchlist(testSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testSeriesDetail);
    // assert
    verify(mockSeriesRepository.removeWatchlist(testSeriesDetail));
    expect(result, const Right('Removed from watchlist'));
  });
}
