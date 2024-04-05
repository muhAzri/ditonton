import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatelessWidget {
  final GetIt locator;

  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<TopRatedMovieBloc>()..add(FetchTopRatedMoviesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top Rated Movies'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
            builder: (context, state) {
              if (state is TopRatedMovieLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieCard(
                      movie,
                      key: Key("top_rated_movie_item_$index"),
                    );
                  },
                  itemCount: state.movies.length,
                );
              }

              if (state is TopRatedMovieFailed) {
                return Center(
                  key: const Key('error_message'),
                  child: Text(state.error),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
