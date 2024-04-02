import 'package:core/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_on_air_series.dart';

class OnAirSeriesNotifier extends ChangeNotifier {
  final GetOnAirSeries getOnAirSeries;

  OnAirSeriesNotifier({required this.getOnAirSeries});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Series> _series = [];
  List<Series> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAirSeries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getOnAirSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (seriesData) {
        _series = seriesData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
