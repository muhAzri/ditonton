import 'package:core/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

class TopRatedSeriesNotifier extends ChangeNotifier {
  final GetTopRatedSeries getTopRatedSeries;

  TopRatedSeriesNotifier({required this.getTopRatedSeries});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<Series> _series = [];
  List<Series> get series => _series;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedSeries() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();

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
