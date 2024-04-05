import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:core/presentation/pages/about_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:series/bloc/home_series/home_series_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/pages/on_air_series_page.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/series_detail_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';

class HomeSeriesPage extends StatelessWidget {
  final GetIt locator;

  const HomeSeriesPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchSeriesPage.routeName);
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
              _buildSubHeading(
                keyPrefix: "btn_on_air",
                title: 'Now On Air',
                onTap: () =>
                    Navigator.pushNamed(context, OnAirSeriesPage.routeName),
              ),
              OnAirSeriesSection(
                locator: locator,
              ),
              _buildSubHeading(
                keyPrefix: "btn_popular",
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularSeriesPage.routeName),
              ),
              PopularSeriesSection(
                locator: locator,
              ),
              _buildSubHeading(
                keyPrefix: "btn_top_rated",
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedSeriesPage.routeName),
              ),
              TopRatedSeriesSection(
                locator: locator,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({
    required String title,
    required Function() onTap,
    required String keyPrefix,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          key: Key("${keyPrefix}_series"),
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
                package: 'core',
              ),
            ),
            accountName: Text('Ditonton'),
            accountEmail: Text('ditonton@dicoding.com'),
          ),
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.tv),
            title: const Text('TV Series'),
            onTap: () {
              Navigator.pop(context);
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

class OnAirSeriesSection extends StatelessWidget {
  final GetIt locator;

  const OnAirSeriesSection({
    super.key,
    required this.locator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeSeriesBloc>()
        ..add(
          FetchOnAirSeriesEvent(),
        ),
      child: BlocBuilder<HomeSeriesBloc, HomeSeriesState>(
        builder: (context, state) {
          if (state is HomeSeriesFailed) {
            return Text(state.error.toString());
          }

          if (state is OnAirSeriesLoaded) {
            return SeriesList(
              state.onAirSeries,
              keyPrefix: "on_air_series",
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

class PopularSeriesSection extends StatelessWidget {
  final GetIt locator;

  const PopularSeriesSection({
    super.key,
    required this.locator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeSeriesBloc>()
        ..add(
          FetchPopularSeriesEvent(),
        ),
      child: BlocBuilder<HomeSeriesBloc, HomeSeriesState>(
        builder: (context, state) {
          if (state is HomeSeriesFailed) {
            return Text(state.error.toString());
          }

          if (state is PopularSeriesLoaded) {
            return SeriesList(
              state.popularSeries,
              keyPrefix: "popular_series",
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

class TopRatedSeriesSection extends StatelessWidget {
  final GetIt locator;

  const TopRatedSeriesSection({
    super.key,
    required this.locator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<HomeSeriesBloc>()
        ..add(
          FetchTopRatedSeriesEvent(),
        ),
      child: BlocBuilder<HomeSeriesBloc, HomeSeriesState>(
        builder: (context, state) {
          if (state is HomeSeriesFailed) {
            return Text(state.error.toString());
          }

          if (state is TopRatedSeriesLoaded) {
            return SeriesList(
              state.topRatedSeries,
              keyPrefix: "top_rated_series",
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

class SeriesList extends StatelessWidget {
  final List<Series> movies;
  final String keyPrefix;

  const SeriesList(this.movies, {super.key, required this.keyPrefix});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final serie = movies[index];
          return Container(
            key: Key("${keyPrefix}_item_$index"),
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.routeName,
                  arguments: serie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${serie.posterPath}',
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
