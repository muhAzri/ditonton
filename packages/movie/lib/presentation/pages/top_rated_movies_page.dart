import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:core/injector.dart' as di;

class TopRatedMoviesPage extends StatelessWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.locator<TopRatedMovieBloc>()..add(FetchTopRatedMoviesEvent()),
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
                    return MovieCard(movie);
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
