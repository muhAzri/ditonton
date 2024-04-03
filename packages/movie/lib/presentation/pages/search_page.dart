import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

class SearchPage extends StatelessWidget {
  final GetIt locator;
  static const routeName = '/search';

  const SearchPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchMovieBloc>(
      create: (_) => locator<SearchMovieBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: const SearchPageContent(),
      ),
    );
  }
}

class SearchPageContent extends StatelessWidget {
  const SearchPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onSubmitted: (query) {
              context.read<SearchMovieBloc>().add(SearchEvent(query));
            },
            decoration: const InputDecoration(
              hintText: 'Search title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          const SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          BlocBuilder<SearchMovieBloc, SearchMovieState>(
            builder: (context, state) {
              if (state is SearchMovieLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SearchMovieLoaded) {
                final result = state.movies;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = result[index];
                      return MovieCard(movie);
                    },
                    itemCount: result.length,
                  ),
                );
              }

              return Expanded(
                key: const Key("Empty State"),
                child: Container(),
              );
            },
          )
        ],
      ),
    );
  }
}
