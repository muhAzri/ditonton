import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/get_on_air_series.dart';
import 'package:ditonton/domain/usecases/get_popular_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_series.dart';
import 'package:flutter/material.dart';

class SeriesListNotifier extends ChangeNotifier {
  var _nowOnAirSeries = <Series>[];
  List<Series> get nowOnAirSeries => _nowOnAirSeries;

  RequestState _nowOnAirState = RequestState.Empty;
  RequestState get nowOnAirState => _nowOnAirState;

  var _popularSeries = <Series>[];
  List<Series> get popularSeries => _popularSeries;

  RequestState _popularSeriesState = RequestState.Empty;
  RequestState get popularSeriesState => _popularSeriesState;

  var _topRatedSeries = <Series>[];
  List<Series> get topRatedSeries => _topRatedSeries;

  RequestState _topRatedSeriesState = RequestState.Empty;
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
    _nowOnAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirSeries.execute();
    result.fold(
      (failure) {
        _nowOnAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _nowOnAirState = RequestState.Loaded;
        _nowOnAirSeries = seriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularSeries() async {
    _popularSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularSeries.execute();
    result.fold(
      (failure) {
        _popularSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _popularSeriesState = RequestState.Loaded;
        _popularSeries = seriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedSeries() async {
    _topRatedSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();
    result.fold(
      (failure) {
        _topRatedSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesData) {
        _topRatedSeriesState = RequestState.Loaded;
        _topRatedSeries = seriesData;
        notifyListeners();
      },
    );
  }
}
