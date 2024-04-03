import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:series/bloc/search_series/search_series_bloc.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class SearchSeriesPage extends StatelessWidget {
  final GetIt locator;
  static const routeName = '/search-series';

  const SearchSeriesPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const SearchSeriesContent(),
    );
  }
}

class SearchSeriesContent extends StatelessWidget {
  const SearchSeriesContent({
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
              context.read<SearchSeriesBloc>().add(SearchEvent(query));
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
          BlocBuilder<SearchSeriesBloc, SearchSeriesState>(
            builder: (context, state) {
              if (state is SearchSeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SearchSeriesLoaded) {
                final result = state.series;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final serie = result[index];
                      return SeriesCard(serie);
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
