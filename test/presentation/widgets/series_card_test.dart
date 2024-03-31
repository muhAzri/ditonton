import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/pages/series_detail_page.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  testWidgets('SerisCard widget test', (WidgetTester tester) async {
    // Arrange
    const series = testSeries;

    await mockNetworkImages(() async {
      await tester.pumpWidget(
        MaterialApp(
          onGenerateRoute: (settings) {
            if (settings.name == '/') {
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: SeriesCard(series),
                ),
              );
            }
            if (settings.name == SeriesDetailPage.ROUTE_NAME) {
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => SeriesDetailPage(
                        id: id,
                      ));
            }
            return null;
          },
        ),
      );
    });

    // Assert
    expect(find.text(series.name!), findsOneWidget);
    expect(find.text(series.overview!), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
