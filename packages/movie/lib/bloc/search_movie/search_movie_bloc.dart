import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/search_movies.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;

  SearchMovieBloc({required this.searchMovies}) : super(SearchMovieInitial()) {
    on<SearchEvent>(onSearchMovie);
  }

  Future<void> onSearchMovie(SearchEvent event, emit) async {
    try {
      emit(SearchMovieLoading());

      final result = await searchMovies.execute(event.query);

      result.fold(
        (error) {
          emit(SearchMovieFailed(error.message));
        },
        (moviesData) {
          emit(SearchMovieLoaded(moviesData));
        },
      );
    } catch (e) {
      emit(SearchMovieFailed(e.toString()));
    }
  }
}
