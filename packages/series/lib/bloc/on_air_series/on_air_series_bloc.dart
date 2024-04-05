import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

part 'on_air_series_event.dart';
part 'on_air_series_state.dart';

class OnAirSeriesBloc extends Bloc<OnAirSeriesEvent, OnAirSeriesState> {
  final GetOnAirSeries getOnAirSeries;

  OnAirSeriesBloc({required this.getOnAirSeries})
      : super(OnAirSeriesInitial()) {
    on<FetchOnAirSeriesEvent>(onFetchOnAirSeries);
  }

  Future<void> onFetchOnAirSeries(FetchOnAirSeriesEvent event, emit) async {
    try {
      emit(OnAirSeriesLoading());

      final result = await getOnAirSeries.execute();

      result.fold(
        (error) {
          emit(OnAirSeriesFailed(error: error.message));
        },
        (seriesData) {
          emit(OnAirSeriesLoaded(series: seriesData));
        },
      );
    } catch (e) {
      emit(OnAirSeriesFailed(error: e.toString()));
    }
  }
}
