import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

part 'top_rated_series_event.dart';
part 'top_rated_series_state.dart';

class TopRatedSeriesBloc
    extends Bloc<TopRatedSeriesEvent, TopRatedSeriesState> {
  final GetTopRatedSeries getTopRatedSeries;

  TopRatedSeriesBloc({required this.getTopRatedSeries})
      : super(TopRatedSeriesInitial()) {
    on<FetchTopRatedSeriesEvent>(onFetchTopRatedSeries);
  }

  Future<void> onFetchTopRatedSeries(
      FetchTopRatedSeriesEvent event, emit) async {
    try {
      emit(TopRatedSeriesLoading());

      final result = await getTopRatedSeries.execute();

      result.fold(
        (error) {
          emit(TopRatedSeriesFailed(error: error.message));
        },
        (seriesData) {
          emit(TopRatedSeriesLoaded(series: seriesData));
        },
      );
    } catch (e) {
      emit(TopRatedSeriesFailed(error: e.toString()));
    }
  }
}
