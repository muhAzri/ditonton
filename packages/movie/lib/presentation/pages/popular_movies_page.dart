import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:core/injector.dart' as di;
import 'package:movie/presentation/widgets/movie_card_list.dart';

class PopularMoviesPage extends StatelessWidget {
  static const routeName = '/popular-movie';

  const PopularMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          di.locator<PopularMovieBloc>()..add(FetchPopularMoviesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Popular Movies'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
            builder: (context, state) {
              if (state is PopularMovieLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return MovieCard(movie);
                  },
                  itemCount: state.movies.length,
                );
              }

              if (state is PopularMovieFailed) {
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
