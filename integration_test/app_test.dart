import 'package:ditonton/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'robots/movie_robot.dart';
import 'robots/series_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  MoviesRobot moviesRobot;
  SeriesRobot seriesRobot;

  group('Test app', () {
    testWidgets('Test Full App', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();

      /// Inisiate value
      moviesRobot = MoviesRobot(widgetTester);
      seriesRobot = SeriesRobot(widgetTester);
      await moviesRobot.startTest();
      await seriesRobot.startTest();
    });
  });
}
