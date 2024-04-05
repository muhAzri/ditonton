import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieBloc({required this.getTopRatedMovies})
      : super(TopRatedMovieInitial()) {
    on<FetchTopRatedMoviesEvent>(onFetchTopRatedMovies);
  }

  Future<void> onFetchTopRatedMovies(
      FetchTopRatedMoviesEvent event, emit) async {
    try {
      emit(TopRatedMovieLoading());

      final result = await getTopRatedMovies.execute();

      result.fold(
        (error) {
          emit(TopRatedMovieFailed(error: error.message));
        },
        (moviesData) {
          emit(TopRatedMovieLoaded(movies: moviesData));
        },
      );
    } catch (e) {
      emit(TopRatedMovieFailed(error: e.toString()));
    }
  }
}
