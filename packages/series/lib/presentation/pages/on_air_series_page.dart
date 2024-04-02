import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/provider/on_air_series_notifier.dart';
import 'package:series/presentation/widgets/series_card_list.dart';

class OnAirSeriesPage extends StatefulWidget {
  static const routeName = '/on-air-series';

  const OnAirSeriesPage({super.key});

  @override
  OnAirSeriesPageState createState() => OnAirSeriesPageState();
}

class OnAirSeriesPageState extends State<OnAirSeriesPage> {
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
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
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
