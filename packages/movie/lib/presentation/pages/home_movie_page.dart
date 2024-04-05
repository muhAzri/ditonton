import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/presentation/pages/about_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/bloc/home_movie/home_movie_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

class HomeMoviePage extends StatelessWidget {
  final GetIt locator;
  const HomeMoviePage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              NowPlayingMovieSection(
                locator: locator,
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  PopularMoviesPage.routeName,
                ),
                buttonKey: "btn_popular_movies",
              ),
              PopularMovieSection(
                locator: locator,
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  TopRatedMoviesPage.routeName,
                ),
                buttonKey: "btn_top_rated_movies",
              ),
              TopRatedMovieSection(
                locator: locator,
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({
    required String title,
    required Function() onTap,
    required String buttonKey,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          key: Key(buttonKey),
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                'assets/circle-g.png',
                package: "core",
              ),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('TV Series'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home-series');
            },
          ),
          ListTile(
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pushNamed(context, WatchlistPage.routeName);
            },
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.routeName);
            },
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
          ),
        ],
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final String keyPrefix;

  const MovieList(this.movies, {super.key, required this.keyPrefix});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            key: Key("${keyPrefix}_item_$index"),
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class NowPlayingMovieSection extends StatelessWidget {
  final GetIt locator;
  const NowPlayingMovieSection({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeMovieBloc>()
        ..add(
          FetchNowPlayingMoviesEvent(),
        ),
      child: BlocBuilder<HomeMovieBloc, HomeMovieState>(
        builder: (context, state) {
          if (state is HomeMovieFailed) {
            return Text(state.error.toString());
          }

          if (state is NowPlayingMoviesLoaded) {
            return MovieList(
              state.nowPlayingMovies,
              keyPrefix: "now_playing_movie",
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PopularMovieSection extends StatelessWidget {
  final GetIt locator;
  const PopularMovieSection({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeMovieBloc>()
        ..add(
          FetchPopularMoviesEvent(),
        ),
      child: BlocBuilder<HomeMovieBloc, HomeMovieState>(
        builder: (context, state) {
          if (state is HomeMovieFailed) {
            return Text(state.error.toString());
          }

          if (state is PopularMoviesLoaded) {
            return MovieList(
              state.popularMovies,
              keyPrefix: "popular_movie",
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class TopRatedMovieSection extends StatelessWidget {
  final GetIt locator;
  const TopRatedMovieSection({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeMovieBloc>()
        ..add(
          FetchTopRatedMoviesEvent(),
        ),
      child: BlocBuilder<HomeMovieBloc, HomeMovieState>(
        builder: (context, state) {
          if (state is HomeMovieFailed) {
            return Text(state.error.toString());
          }

          if (state is TopRatedMoviesLoaded) {
            return MovieList(
              state.topRatedMovies,
              keyPrefix: "top_rated_movie",
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
