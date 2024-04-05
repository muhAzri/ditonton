import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';

part 'watchlist_series_event.dart';
part 'watchlist_series_state.dart';

class WatchlistSeriesBloc
    extends Bloc<WatchlistSeriesEvent, WatchlistSeriesState> {
  final GetWatchlistSeries getWatchlistSeries;

  WatchlistSeriesBloc({required this.getWatchlistSeries})
      : super(WatchlistSeriesInitial()) {
    on<FetchWatchlistSeriesEvents>(onFetchWatchlistSeries);
  }

  Future<void> onFetchWatchlistSeries(
      FetchWatchlistSeriesEvents event, emit) async {
    try {
      emit(WatchlistSeriesLoading());

      final result = await getWatchlistSeries.execute();

      result.fold(
        (error) {
          emit(
            WatchlistSeriesFailed(error.message),
          );
        },
        (seriesData) {
          emit(
            WatchlistSeriesLoaded(seriesData),
          );
        },
      );
    } catch (e) {
      emit(
        WatchlistSeriesFailed(
          e.toString(),
        ),
      );
    }
  }
}
