import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'drawer_robot.dart';
import 'series/home_series_robot.dart';
import 'series/on_air_series_robot.dart';
import 'series/popular_series_robot.dart';
import 'series/search_series_robot.dart';
import 'series/series_detail_robot.dart';
import 'series/top_rated_series_robot.dart';
import 'series/watchlist_series_robot.dart';

class SeriesRobot {
  final WidgetTester tester;
  SeriesRobot(this.tester);

  late DrawerAppRobot drawerAppRobot;
  late HomeSeriesRobot homeSeriesRobot;
  late OnAirSeriesRobot onAirSeriesRobot;
  late PopularSeriesRobot popularSeriesRobot;
  late TopRatedSeriesRobot topRatedSeriesRobot;
  late SearchSeriesRobot searchSeriesRobot;
  late SeriesDetailRobot seriesDetailRobot;
  late WatchlistSeriesRobot watchlistSeriesRobot;

  Future<void> _initialize() async {
    drawerAppRobot = DrawerAppRobot(tester);
    homeSeriesRobot = HomeSeriesRobot(tester);
    onAirSeriesRobot = OnAirSeriesRobot(tester);
    popularSeriesRobot = PopularSeriesRobot(tester);
    topRatedSeriesRobot = TopRatedSeriesRobot(tester);
    searchSeriesRobot = SearchSeriesRobot(tester);
    seriesDetailRobot = SeriesDetailRobot(tester);
    watchlistSeriesRobot = WatchlistSeriesRobot(tester);
  }

  Future<void> _homePageTest() async {
    await drawerAppRobot.clickNavigationDrawerButton();
    await drawerAppRobot.clickNavigationDrawerButtonHomeSeries();
    await homeSeriesRobot.scrollSeriePage();
    await homeSeriesRobot.scrollSeriePage(scrollUp: true);
  }

  Future<void> _onAirSeriesPageTest() async {
    await homeSeriesRobot.clickSeeMoreOnAirSeries();
    await onAirSeriesRobot.scrollOnAirSeriesPage();
    await onAirSeriesRobot.scrollOnAirSeriesPage(scrollUp: true);
    await onAirSeriesRobot.goBack();
  }

  Future<void> _popularSeriesPageTest() async {
    await homeSeriesRobot.clickSeeMorePopularSeries();
    await popularSeriesRobot.scrollPopularSeriesPage();
    await popularSeriesRobot.scrollPopularSeriesPage(scrollUp: true);
    await popularSeriesRobot.goBack();
  }

  Future<void> _topRatedSeriesPageTest() async {
    await homeSeriesRobot.clickSeeMoreTopRatedSeries();
    await topRatedSeriesRobot.scrollTopRatedSeriesPage();
    await topRatedSeriesRobot.scrollTopRatedSeriesPage(scrollUp: true);
    await topRatedSeriesRobot.goBack();
  }

  Future<void> _searchSeriesPageTest() async {
    await homeSeriesRobot.clickSearchSeriesButton();
    await searchSeriesRobot.enterSearchQuery('Breaking Bad');
    await searchSeriesRobot.scrollSearchSeriesPage();
    await searchSeriesRobot.scrollSearchSeriesPage(scrollUp: true);
    await searchSeriesRobot.goBack();
  }

  Future<void> _seriesDetailPageTest() async {
    await homeSeriesRobot.clickSeriesItem(keyList: "popular_series_item_0");
    await seriesDetailRobot.scrollDetailSeriesPage();
    await seriesDetailRobot.scrollDetailSeriesPage(scrollUp: true);
    await seriesDetailRobot.scrollRecomendationSeriesPage();
    await seriesDetailRobot.scrollRecomendationSeriesPage(scrollBack: true);
    // Add to watchlist
    expect(find.byIcon(Icons.add), findsOneWidget);
    await seriesDetailRobot.clickSeriesAddToWatchlistButton();
    await seriesDetailRobot.goBack();
  }

  Future<void> _watchlistPageTest() async {
    await drawerAppRobot.clickNavigationDrawerButton();
    await drawerAppRobot.clickWatchlistListTile();
    await watchlistSeriesRobot.switchToSeriesWatchlist();

    // // Watchlist movie page
    await watchlistSeriesRobot.scrollWatchlistSeriesPage();
    await watchlistSeriesRobot.scrollWatchlistSeriesPage(scrollUp: true);
    await watchlistSeriesRobot.clickSeriesItemWatchlist();
    // // Go To Detail From Watchlist
    await seriesDetailRobot.scrollDetailSeriesPage();
    await seriesDetailRobot.scrollDetailSeriesPage(scrollUp: true);
    await seriesDetailRobot.scrollRecomendationSeriesPage();
    await seriesDetailRobot.scrollRecomendationSeriesPage(scrollBack: true);
    expect(find.byIcon(Icons.check), findsOneWidget);
    await seriesDetailRobot.clickSeriesRemoveFromWatchlistButton();
    await seriesDetailRobot.goBackToWatchlist();
    await watchlistSeriesRobot.goBack();
  }

  Future<void> startTest() async {
    await _initialize();
    await _homePageTest();
    await _onAirSeriesPageTest();
    await _popularSeriesPageTest();
    await _topRatedSeriesPageTest();
    await _searchSeriesPageTest();
    await _seriesDetailPageTest();
    await _watchlistPageTest();
  }
}
