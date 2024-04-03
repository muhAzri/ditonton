import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/usecases/usecases.dart';

part 'series_detail_event.dart';
part 'series_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSeriesDetail getSeriesDetail;
  final GetSeriesRecommendations getSeriesRecommendations;
  final GetWatchListSeriesStatus getWatchListSeriesStatus;
  final SaveSeriesWatchlist saveSeriesWatchlist;
  final RemoveSeriesWatchlist removeSeriesWatchlist;

  SeriesDetailBloc({
    required this.getSeriesDetail,
    required this.getSeriesRecommendations,
    required this.getWatchListSeriesStatus,
    required this.saveSeriesWatchlist,
    required this.removeSeriesWatchlist,
  }) : super(SeriesDetailInitial()) {
    on<FetchSeriesDetailEvent>(onFetchSeriesDetail);
    on<FetchSeriesRecommendationsEvent>(onFetchSeriesRecommendations);
    on<GetWatchlistStatusEvent>(onFetchWatchListStatus);
    on<SaveWatchlistEvent>(onSaveWatchlist);
    on<RemoveWatchlistEvent>(onRemoveWatchlist);
  }

  Future<void> onFetchSeriesDetail(
    FetchSeriesDetailEvent event,
    emit,
  ) async {
    try {
      emit(SeriesDetailLoading());

      final result = await getSeriesDetail.execute(event.tID);

      result.fold(
        (error) {
          emit(
            SeriesDetailFailed(error.message),
          );
        },
        (seriesData) {
          emit(
            SeriesDetailLoaded(seriesDetail: seriesData),
          );
        },
      );
    } catch (e) {
      emit(SeriesDetailFailed(e.toString()));
    }
  }

  Future<void> onFetchSeriesRecommendations(
    FetchSeriesRecommendationsEvent event,
    emit,
  ) async {
    try {
      emit(SeriesDetailLoading());

      final result = await getSeriesRecommendations.execute(event.tID);

      result.fold(
        (error) {
          emit(
            SeriesDetailFailed(error.message),
          );
        },
        (seriesData) {
          emit(
            SeriesRecommendationLoaded(
              recommendationSeries: seriesData,
            ),
          );
        },
      );
    } catch (e) {
      emit(SeriesDetailFailed(e.toString()));
    }
  }

  Future<void> onFetchWatchListStatus(
    GetWatchlistStatusEvent event,
    emit,
  ) async {
    try {
      emit(SeriesDetailLoading());

      final result = await getWatchListSeriesStatus.execute(event.tID);

      emit(WatchlistStatusLoaded(result));
    } catch (e) {
      emit(SeriesDetailFailed(e.toString()));
    }
  }

  Future<void> onSaveWatchlist(
    SaveWatchlistEvent event,
    emit,
  ) async {
    try {
      emit(SeriesDetailLoading());

      final result = await saveSeriesWatchlist.execute(event.serie);

      await result.fold(
        (error) {
          emit(
            SeriesDetailFailed(error.message),
          );
        },
        (watchlistMessage) async {
          emit(WatchlistChangeSuccess(message: watchlistMessage));
          final newResult = await getWatchListSeriesStatus.execute(
            event.serie.id,
          );
          emit(WatchlistStatusLoaded(newResult));
        },
      );
    } catch (e) {
      emit(SeriesDetailFailed(e.toString()));
    }
  }

  Future<void> onRemoveWatchlist(
    RemoveWatchlistEvent event,
    emit,
  ) async {
    try {
      emit(SeriesDetailLoading());

      final result = await removeSeriesWatchlist.execute(event.serie);

      await result.fold(
        (error) {
          emit(
            SeriesDetailFailed(error.message),
          );
        },
        (watchlistMessage) async {
          emit(WatchlistChangeSuccess(message: watchlistMessage));
          final newResult = await getWatchListSeriesStatus.execute(
            event.serie.id,
          );
          emit(WatchlistStatusLoaded(newResult));
        },
      );
    } catch (e) {
      emit(SeriesDetailFailed(e.toString()));
    }
  }
}
