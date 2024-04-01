import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/series/on_air_series_notifier.dart';
import 'package:ditonton/presentation/widgets/series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnAirSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-series';

  const OnAirSeriesPage({super.key});

  @override
  _OnAirSeriesPageState createState() => _OnAirSeriesPageState();
}

class _OnAirSeriesPageState extends State<OnAirSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnAirSeriesNotifier>(context, listen: false)
            .fetchOnAirSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Air Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnAirSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final serie = data.series[index];
                  return SeriesCard(serie);
                },
                itemCount: data.series.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
