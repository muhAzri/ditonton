import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

part 'home_series_event.dart';
part 'home_series_state.dart';

class HomeSeriesBloc extends Bloc<HomeSeriesEvent, HomeSeriesState> {
  final GetOnAirSeries getOnAirSeries;
  final GetPopularSeries getPopularSeries;
  final GetTopRatedSeries getTopRatedSeries;

  HomeSeriesBloc({
    required this.getOnAirSeries,
    required this.getPopularSeries,
    required this.getTopRatedSeries,
  }) : super(HomeSeriesInitial()) {
    on<FetchOnAirSeriesEvent>(onFetchNowPlayingSeries);
    on<FetchPopularSeriesEvent>(onFetchPopularSeries);
    on<FetchTopRatedSeriesEvent>(onFetchTopRatedSeries);
  }

  Future<void> onFetchNowPlayingSeries(
      FetchOnAirSeriesEvent event, emit) async {
    try {
      emit(HomeSeriesLoading());

      final series = await getOnAirSeries.execute();

      series.fold((error) {
        emit(
          HomeSeriesFailed(
            error: error.message,
          ),
        );
      }, (seriesData) {
        emit(
          OnAirSeriesLoaded(
            onAirSeries: seriesData,
          ),
        );
      });
    } catch (e) {
      emit(HomeSeriesFailed(error: e.toString()));
    }
  }

  Future<void> onFetchPopularSeries(FetchPopularSeriesEvent event, emit) async {
    try {
      emit(HomeSeriesLoading());

      final series = await getPopularSeries.execute();

      series.fold((error) {
        emit(
          HomeSeriesFailed(
            error: error.message,
          ),
        );
      }, (seriesData) {
        emit(
          PopularSeriesLoaded(
            popularSeries: seriesData,
          ),
        );
      });
    } catch (e) {
      emit(HomeSeriesFailed(error: e.toString()));
    }
  }

  Future<void> onFetchTopRatedSeries(
      FetchTopRatedSeriesEvent event, emit) async {
    try {
      emit(HomeSeriesLoading());

      final series = await getTopRatedSeries.execute();

      series.fold((error) {
        emit(
          HomeSeriesFailed(
            error: error.message,
          ),
        );
      }, (seriesData) {
        emit(
          TopRatedSeriesLoaded(
            topRatedSeries: seriesData,
          ),
        );
      });
    } catch (e) {
      emit(HomeSeriesFailed(error: e.toString()));
    }
  }
}
