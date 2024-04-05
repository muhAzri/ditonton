import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:series/bloc/popular_series.dart/popular_series_bloc.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class PopularSeriesPage extends StatelessWidget {
  final GetIt locator;
  static const routeName = '/popular-series';

  const PopularSeriesPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<PopularSeriesBloc>()..add(FetchPopularSeriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Popular Series'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
            builder: (context, state) {
              if (state is PopularSeriesLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final serie = state.series[index];
                    return SeriesCard(
                      serie,
                      key: Key("popular_series_item_$index"),
                    );
                  },
                  itemCount: state.series.length,
                );
              }

              if (state is PopularSeriesFailed) {
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
