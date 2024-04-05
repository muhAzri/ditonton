import 'package:flutter_test/flutter_test.dart';
import 'package:movie/bloc/movie_detail/movie_detail_bloc.dart';

import '../dummy_data/dummy_objects.dart';

void main() {
  group('MovieDetailEvent', () {
    test('FetchMovieDetailEvent props', () {
      const event1 = FetchMovieDetailEvent(tID: 1);
      const event2 = FetchMovieDetailEvent(tID: 1);
      const event3 = FetchMovieDetailEvent(tID: 2);

      expect(event1.props, [1]);
      expect(event1, event2); // Equality test
      expect(event1 == event3, false); // Inequality test
    });

    test('FetchMovieRecommendationsEvent props', () {
      const event1 = FetchMovieRecommendationsEvent(tID: 1);
      const event2 = FetchMovieRecommendationsEvent(tID: 1);
      const event3 = FetchMovieRecommendationsEvent(tID: 2);

      expect(event1.props, [1]);
      expect(event1, event2); // Equality test
      expect(event1 == event3, false); // Inequality test
    });

    test('SaveWatchlistEvent props', () {
      const movie1 =
          testMovieDetail; // Provide appropriate data for MovieDetail
      const movie2 =
          testMovieDetail2; // Provide appropriate data for MovieDetail
      const event1 = SaveWatchlistEvent(movie: movie1);
      const event2 = SaveWatchlistEvent(movie: movie1);
      const event3 = SaveWatchlistEvent(movie: movie2);

      expect(event1.props, [movie1]);
      expect(event1, event2); // Equality test
      expect(event1 == event3, false); // Inequality test
    });

    test('RemoveWatchlistEvent props', () {
      const movie1 =
          testMovieDetail; // Provide appropriate data for MovieDetail
      const movie2 =
          testMovieDetail2; // Provide appropriate data for MovieDetail
      const event1 = RemoveWatchlistEvent(movie: movie1);
      const event2 = RemoveWatchlistEvent(movie: movie1);
      const event3 = RemoveWatchlistEvent(movie: movie2);

      expect(event1.props, [movie1]);
      expect(event1, event2); // Equality test
      expect(event1 == event3, false); // Inequality test
    });

    test('GetWatchlistStatusEvent props', () {
      const event1 = GetWatchlistStatusEvent(tID: 1);
      const event2 = GetWatchlistStatusEvent(tID: 1);
      const event3 = GetWatchlistStatusEvent(tID: 2);

      expect(event1.props, [1]);
      expect(event1, event2); // Equality test
      expect(event1 == event3, false); // Inequality test
    });
  });
}
