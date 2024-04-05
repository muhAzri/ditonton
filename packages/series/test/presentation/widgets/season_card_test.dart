import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:series/domain/entities/season.dart';
import 'package:series/presentation/widgets/season_card.dart';

void main() {
  testWidgets('SeasonCard widget test', (WidgetTester tester) async {
    // Arrange
    const season = Season(
      airDate: '2022-01-01',
      episodeCount: 10,
      id: 1,
      name: 'Season 1',
      overview: 'Season 1 overview',
      posterPath: '/path/to/poster.jpg',
      seasonNumber: 1,
      voteAverage: 8.5,
    );

    await mockNetworkImages(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SeasonCard(season: season),
          ),
        ),
      );
    });

    // Assert
    expect(find.text(season.name), findsWidgets);
    expect(find.text('Air Date: ${season.airDate}'), findsOneWidget);
    expect(find.text('Episode Count: ${season.episodeCount}'), findsOneWidget);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
