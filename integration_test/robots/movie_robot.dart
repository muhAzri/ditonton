import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'drawer_robot.dart';
import 'movie/home_movie_robot.dart';
import 'movie/movie_detail_robot.dart';
import 'movie/popular_movie_robot.dart';
import 'movie/search_movie_robot.dart';
import 'movie/top_rated_movie_robot.dart';
import 'movie/watchlist_movie_robot.dart';

class MoviesRobot {
  final WidgetTester tester;
  MoviesRobot(this.tester);

  late DrawerAppRobot drawerAppRobot;
  late HomeMovieRobot homeMovieRobot;
  late PopularMovieRobot popularMovieRobot;
  late TopRatedMovieRobot topRatedMovieRobot;
  late SearchMovieRobot searchMovieRobot;
  late MovieDetailRobot movieDetailRobot;
  late WatchlistMovieRobot watchlistMovieRobot;

  Future<void> _initialize() async {
    drawerAppRobot = DrawerAppRobot(tester);
    homeMovieRobot = HomeMovieRobot(tester);
    popularMovieRobot = PopularMovieRobot(tester);
    topRatedMovieRobot = TopRatedMovieRobot(tester);
    searchMovieRobot = SearchMovieRobot(tester);
    movieDetailRobot = MovieDetailRobot(tester);
    watchlistMovieRobot = WatchlistMovieRobot(tester);
  }

  Future<void> _homePageTest() async {
    await homeMovieRobot.scrollMoviePage();
    await homeMovieRobot.scrollMoviePage(scrollUp: true);
  }

  Future<void> _popularMoviePageTest() async {
    await homeMovieRobot.clickSeeMorePopularMovies();
    await popularMovieRobot.scrollPopularMoviePage();
    await popularMovieRobot.scrollPopularMoviePage(scrollUp: true);
    await popularMovieRobot.goBack();
  }

  Future<void> _topRatedMoviePageTest() async {
    await homeMovieRobot.clickSeeMoreTopRatedMovies();
    await topRatedMovieRobot.scrollTopRatedMoviePage();
    await topRatedMovieRobot.scrollTopRatedMoviePage(scrollUp: true);
    await topRatedMovieRobot.goBack();
  }

  Future<void> _searchMoviePageTest() async {
    await homeMovieRobot.clickSearchMovieButton();
    await searchMovieRobot
        .enterSearchQuery('Godfather'); // The Query is Godfather
    await searchMovieRobot.scrollSearchMoviePage();
    await searchMovieRobot.scrollSearchMoviePage(scrollUp: true);
    await searchMovieRobot.goBack();
  }

  Future<void> _movieDetailPageTest() async {
    await homeMovieRobot.clickMovieItem(keyList: 'popular_movie_item_0');
    await movieDetailRobot.scrollDetailMoviePage();
    await movieDetailRobot.scrollRecomendationMovieDetailPage();
    await movieDetailRobot.scrollRecomendationMovieDetailPage(scrollBack: true);
    await movieDetailRobot.scrollDetailMoviePage(scrollUp: true);
    // Add to watchlist
    expect(find.byIcon(Icons.add), findsOneWidget);
    await movieDetailRobot.clickMovieAddToWatchlistButton();
    await movieDetailRobot.goBack();
  }

  Future<void> _watchlistPageTest() async {
    await drawerAppRobot.clickNavigationDrawerButton();
    await drawerAppRobot.clickWatchlistListTile();
    // Watchlist movie page
    await watchlistMovieRobot.scrollWatchlistMoviePage();
    await watchlistMovieRobot.scrollWatchlistMoviePage(scrollUp: true);
    await watchlistMovieRobot.clickMovieItemWatchlist();
    // Go To Detail From Watchlist
    await movieDetailRobot.scrollDetailMoviePage();
    await movieDetailRobot.scrollRecomendationMovieDetailPage();
    await movieDetailRobot.scrollRecomendationMovieDetailPage(scrollBack: true);
    await movieDetailRobot.scrollDetailMoviePage(scrollUp: true);
    expect(find.byIcon(Icons.check), findsOneWidget);
    await movieDetailRobot.clickMovieRemoveFromWatchlistButton();
    await movieDetailRobot.goBackToWatchlist();
    await watchlistMovieRobot.goBack();
  }

  Future<void> startTest() async {
    await _initialize();
    await _homePageTest();
    await _popularMoviePageTest();
    await _topRatedMoviePageTest();
    await _searchMoviePageTest();
    await _movieDetailPageTest();
    await _watchlistPageTest();
  }
}
