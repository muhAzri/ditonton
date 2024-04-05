import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:series/bloc/watchlist_series/watchlist_series_bloc.dart';
import 'package:core/injector.dart' as di;
import 'package:series/presentation/widgets/series_card_list.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({super.key});

  @override
  WatchlistPageState createState() => WatchlistPageState();
}

class WatchlistPageState extends State<WatchlistPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<WatchlistSeriesBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Movies'),
              Tab(text: 'Series'),
            ],
          ),
        ),
        body: WatchlistTab(tabController: _tabController),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class WatchlistTab extends StatefulWidget {
  const WatchlistTab({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  State<WatchlistTab> createState() => _WatchlistTabState();
}

class _WatchlistTabState extends State<WatchlistTab> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovieEvents());
    context.read<WatchlistSeriesBloc>().add(FetchWatchlistSeriesEvents());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovieEvents());
    context.read<WatchlistSeriesBloc>().add(FetchWatchlistSeriesEvents());
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget._tabController,
      children: const [
        MovieContent(),
        SeriesContent(),
      ],
    );
  }
}

class MovieContent extends StatelessWidget {
  const MovieContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieFailed) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.error),
            );
          }

          if (state is WatchlistMovieLoaded) {
            if (state.movies.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.movie_creation, size: 50),
                    SizedBox(height: 8),
                    Text('No movies in your watchlist.'),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(
                    movie,
                    key: Key("watchlist_movie_item_$index"),
                  );
                },
                itemCount: state.movies.length,
              );
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class SeriesContent extends StatelessWidget {
  const SeriesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistSeriesBloc, WatchlistSeriesState>(
        builder: (context, state) {
          if (state is WatchlistSeriesFailed) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.error),
            );
          }

          if (state is WatchlistSeriesLoaded) {
            if (state.series.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.tv, size: 50),
                    SizedBox(height: 8),
                    Text('No series in your watchlist.'),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = state.series[index];
                  return SeriesCard(
                    serie,
                    key: Key("watchlist_series_item_$index"),
                  );
                },
                itemCount: state.series.length,
              );
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
