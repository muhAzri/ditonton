import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:series/bloc/on_air_series/on_air_series_bloc.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class OnAirSeriesPage extends StatelessWidget {
  final GetIt locator;
  static const routeName = '/on-air-series';

  const OnAirSeriesPage({super.key, required this.locator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<OnAirSeriesBloc>()..add(FetchOnAirSeriesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('On Air Series'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<OnAirSeriesBloc, OnAirSeriesState>(
            builder: (context, state) {
              if (state is OnAirSeriesLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final serie = state.series[index];
                    return SeriesCard(
                      serie,
                      key: Key("on_air_series_item_$index"),
                    );
                  },
                  itemCount: state.series.length,
                );
              }

              if (state is OnAirSeriesFailed) {
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
