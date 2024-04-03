import 'package:flutter_test/flutter_test.dart';
import 'package:movie/bloc/search_movie/search_movie_bloc.dart';

void main() {
  group('MovieSearchEvent', () {
    test('FetchMovieDetailEvent props', () {
      const event1 = SearchEvent("Spiderman");
      const event2 = SearchEvent("Spiderman");
      const event3 = SearchEvent("Batman");

      expect(event1.props, ["Spiderman"]);
      expect(event1, event2); // Equality test
      expect(event1 == event3, false); // Inequality test
    });
  });
}
