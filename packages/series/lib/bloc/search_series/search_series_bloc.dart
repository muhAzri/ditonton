import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/usecases.dart';

part 'search_series_event.dart';
part 'search_series_state.dart';

class SearchSeriesBloc extends Bloc<SearchSeriesEvent, SearchSeriesState> {
  final SearchSeries searchSeries;

  SearchSeriesBloc({required this.searchSeries})
      : super(SearchSeriesInitial()) {
    on<SearchEvent>(onSearchSeries);
  }

  Future<void> onSearchSeries(SearchEvent event, emit) async {
    try {
      emit(SearchSeriesLoading());

      final result = await searchSeries.execute(event.query);

      result.fold(
        (error) {
          emit(SearchSeriesFailed(error.message));
        },
        (seriesData) {
          emit(SearchSeriesLoaded(seriesData));
        },
      );
    } catch (e) {
      emit(SearchSeriesFailed(e.toString()));
    }
  }
}
