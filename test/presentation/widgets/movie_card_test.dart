import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/pages/movies/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  testWidgets('MovieCard widget test', (WidgetTester tester) async {
    // Arrange
    const movie = testMovie;

    await mockNetworkImages(() async {
      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == '/') {
              return MaterialPageRoute(
                builder: (_) => const Scaffold(
                  body: MovieCard(movie),
                ),
              );
            }
            if (settings.name == MovieDetailPage.ROUTE_NAME) {
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => MovieDetailPage(
                        id: id,
                      ));
            }
            return null;
          },
        ),
      );
    });

    // Assert
    expect(find.text(movie.title!), findsOneWidget);
    expect(find.text(movie.overview!), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
