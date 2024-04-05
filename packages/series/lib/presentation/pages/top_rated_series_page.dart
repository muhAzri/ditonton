import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:series/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class TopRatedSeriesPage extends StatelessWidget {
  static const routeName = '/top-rated-serie';
  final GetIt locator;

  const TopRatedSeriesPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<TopRatedSeriesBloc>()..add(FetchTopRatedSeriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top Rated Series'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
            builder: (context, state) {
              if (state is TopRatedSeriesLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final serie = state.series[index];
                    return SeriesCard(
                      serie,
                      key: Key("top_rated_series_item_$index"),
                    );
                  },
                  itemCount: state.series.length,
                );
              }

              if (state is TopRatedSeriesFailed) {
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
