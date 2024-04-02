import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/provider/watchlist_series_notifier.dart';
import 'package:series/presentation/widgets/series_card_list.dart';
import 'package:core/injector.dart' as di;

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
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
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
        body: TabBarView(
          controller: _tabController,
          children: const [
            MovieContent(),
            SeriesContent(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class MovieContent extends StatefulWidget {
  const MovieContent({super.key});

  @override
  State<MovieContent> createState() => _MovieContentState();
}

class _MovieContentState extends State<MovieContent> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovieEvents());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    // Provider.of<WatchlistSeriesNotifier>(context, listen: false)
    //     .fetchWatchlistSeries();
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovieEvents());
  }

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
                    return MovieCard(movie);
                  },
                  itemCount: state.movies.length,
                );
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

class SeriesContent extends StatelessWidget {
  const SeriesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WatchlistSeriesNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.loaded) {
            if (data.watchlistSeries.isEmpty) {
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
                  final serie = data.watchlistSeries[index];
                  return SeriesCard(serie);
                },
                itemCount: data.watchlistSeries.length,
              );
            }
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
