import 'package:core/common/state_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/usecases/usecases.dart';

class SeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final GetWatchListSeriesStatus getWatchListSeriesStatus;
  final SaveSeriesWatchlist saveSeriesWatchlist;
  final RemoveSeriesWatchlist removeSeriesWatchlist;

  SeriesDetailNotifier({
    required this.getSeriesDetail,
    required this.getSeriesRecommendations,
    required this.getWatchListSeriesStatus,
    required this.saveSeriesWatchlist,
    required this.removeSeriesWatchlist,
  });

  late SeriesDetail _series;
  SeriesDetail get series => _series;

  RequestState _seriesState = RequestState.empty;
  RequestState get seriesState => _seriesState;

  List<Series> _serisRecommendation = [];
  List<Series> get seriesRecommendation => _serisRecommendation;

  RequestState _recommendationState = RequestState.empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchSeriesDetail(int id) async {
    _seriesState = RequestState.loading;
    notifyListeners();
    final detailResult = await getSeriesDetail.execute(id);
    final recommendationResult = await getSeriesRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _seriesState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (series) {
        _recommendationState = RequestState.loading;
        _series = series;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (series) {
            _recommendationState = RequestState.loaded;
            _serisRecommendation = series;
          },
        );
        _seriesState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(SeriesDetail series) async {
    final result = await saveSeriesWatchlist.execute(series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  Future<void> removeFromWatchlist(SeriesDetail series) async {
    final result = await removeSeriesWatchlist.execute(series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListSeriesStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
