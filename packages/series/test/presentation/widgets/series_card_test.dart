void main() {
  // testWidgets('SerisCard widget test', (WidgetTester tester) async {
  //   // Arrange
  //   const series = testSeries;

  //   await mockNetworkImages(() async {
  //     await tester.pumpWidget(
  //       MaterialApp(
  //         onGenerateRoute: (settings) {
  //           if (settings.name == '/') {
  //             return MaterialPageRoute(
  //               builder: (_) => const Scaffold(
  //                 body: SeriesCard(series),
  //               ),
  //             );
  //           }
  //           if (settings.name == SeriesDetailPage.routeName) {
  //             final id = settings.arguments as int;
  //             return MaterialPageRoute(
  //                 builder: (_) => SeriesDetailPage(
  //                       id: id,
  //                     ));
  //           }
  //           return null;
  //         },
  //       ),
  //     );
  //   });

  //   // Assert
  //   expect(find.text(series.name!), findsOneWidget);
  //   expect(find.text(series.overview!), findsOneWidget);
  //   expect(find.byType(CachedNetworkImage), findsOneWidget);
  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });
}
