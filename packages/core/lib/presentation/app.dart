import 'package:core/common/constants.dart';
import 'package:core/common/utils.dart';
import 'package:core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';

import 'package:core/injector.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        colorScheme: kColorScheme,
        primaryColor: kRichBlack,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
      ),
      home: HomeMoviePage(
        locator: di.locator,
      ),
      navigatorObservers: [routeObserver],
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
