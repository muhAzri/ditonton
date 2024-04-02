import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieBloc({required this.getPopularMovies})
      : super(PopularMovieInitial()) {
    on<FetchPopularMoviesEvent>(onFetchPopularMovies);
  }

  Future<void> onFetchPopularMovies(FetchPopularMoviesEvent event, emit) async {
    try {
      emit(PopularMovieLoading());

      final result = await getPopularMovies.execute();

      result.fold(
        (error) {
          emit(PopularMovieFailed(error: error.message));
        },
        (moviesData) {
          emit(PopularMovieLoaded(movies: moviesData));
        },
      );
    } catch (e) {
      emit(PopularMovieFailed(error: e.toString()));
    }
  }
}
