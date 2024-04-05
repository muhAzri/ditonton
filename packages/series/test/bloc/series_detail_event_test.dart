import 'package:flutter_test/flutter_test.dart';
import 'package:series/bloc/series_detail/series_detail_bloc.dart';

import '../dummy_data/dummy_objects.dart';

void main() {
  group('SeriesDetailEvent props tests', () {
    test('FetchSeriesDetailEvent props', () {
      const event1 = FetchSeriesDetailEvent(tID: 1);
      const event2 = FetchSeriesDetailEvent(tID: 1);
      const event3 = FetchSeriesDetailEvent(tID: 2);

      expect(event1.props, equals([1]));
      expect(event1.props, equals(event2.props));
      expect(event1.props, isNot(equals(event3.props)));
    });

    test('FetchSeriesRecommendationsEvent props', () {
      const event1 = FetchSeriesRecommendationsEvent(tID: 1);
      const event2 = FetchSeriesRecommendationsEvent(tID: 1);
      const event3 = FetchSeriesRecommendationsEvent(tID: 2);

      expect(event1.props, equals([1]));
      expect(event1.props, equals(event2.props));
      expect(event1.props, isNot(equals(event3.props)));
    });

    test('SaveWatchlistEvent props', () {
      const series = testSeriesDetail;
      const event1 = SaveWatchlistEvent(serie: series);
      const event2 = SaveWatchlistEvent(serie: series);

      expect(event1.props, equals([series]));
      expect(event1.props, equals(event2.props));
    });

    test('RemoveWatchlistEvent props', () {
      const series = testSeriesDetail;
      const event1 = RemoveWatchlistEvent(serie: series);
      const event2 = RemoveWatchlistEvent(serie: series);

      expect(event1.props, equals([series]));
      expect(event1.props, equals(event2.props));
    });

    test('GetWatchlistStatusEvent props', () {
      const event1 = GetWatchlistStatusEvent(tID: 1);
      const event2 = GetWatchlistStatusEvent(tID: 1);
      const event3 = GetWatchlistStatusEvent(tID: 2);

      expect(event1.props, equals([1]));
      expect(event1.props, equals(event2.props));
      expect(event1.props, isNot(equals(event3.props)));
    });
  });
}
