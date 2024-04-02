import 'package:core/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

class SeriesListNotifier extends ChangeNotifier {
  var _nowOnAirSeries = <Series>[];
  List<Series> get nowOnAirSeries => _nowOnAirSeries;

  RequestState _nowOnAirState = RequestState.empty;
  RequestState get nowOnAirState => _nowOnAirState;

  var _popularSeries = <Series>[];
  List<Series> get popularSeries => _popularSeries;

  RequestState _popularSeriesState = RequestState.empty;
  RequestState get popularSeriesState => _popularSeriesState;

  var _topRatedSeries = <Series>[];
  List<Series> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.empty;
  RequestState get topRatedSeriesState => _topRatedSeriesState;

  String _message = '';
  String get message => _message;

  SeriesListNotifier({
    required this.getOnAirSeries,
    required this.getPopularSeries,
    required this.getTopRatedSeries,
  });

  final GetOnAirSeries getOnAirSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;

  Future<void> fetchOnAirSeries() async {
    _nowOnAirState = RequestState.loading;
    notifyListeners();

    final result = await getOnAirSeries.execute();
    result.fold(
      (failure) {
        _nowOnAirState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _nowOnAirState = RequestState.loaded;
        _nowOnAirSeries = seriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularSeries() async {
    _popularSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold(
      (failure) {
        _popularSeriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _popularSeriesState = RequestState.loaded;
        _popularSeries = seriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedSeriesState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold(
      (failure) {
        _topRatedSeriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _topRatedSeriesState = RequestState.loaded;
        _topRatedSeries = seriesData;
        notifyListeners();
      },
    );
  }
}
