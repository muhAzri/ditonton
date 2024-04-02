import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/usecases.dart';

part 'home_movie_event.dart';
part 'home_movie_state.dart';

class HomeMovieBloc extends Bloc<HomeMovieEvent, HomeMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  HomeMovieBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(HomeMovieInitial()) {
    on<FetchNowPlayingMoviesEvent>(onFetchNowPlayingMovie);
    on<FetchPopularMoviesEvent>(onFetchPopularMovie);
    on<FetchTopRatedMoviesEvent>(onFetchTopRatedMovie);
  }

  Future<void> onFetchNowPlayingMovie(
      FetchNowPlayingMoviesEvent event, emit) async {
    try {
      emit(HomeMovieLoading());

      final movies = await getNowPlayingMovies.execute();

      movies.fold((error) {
        emit(
          HomeMovieFailed(
            error: error.message,
          ),
        );
      }, (moviesData) {
        emit(
          NowPlayingMoviesLoaded(
            nowPlayingMovies: moviesData,
          ),
        );
      });
    } catch (e) {
      emit(HomeMovieFailed(error: e.toString()));
    }
  }

  Future<void> onFetchPopularMovie(FetchPopularMoviesEvent event, emit) async {
    try {
      emit(HomeMovieLoading());

      final movies = await getPopularMovies.execute();

      movies.fold((error) {
        emit(
          HomeMovieFailed(
            error: error.message,
          ),
        );
      }, (moviesData) {
        emit(
          PopularMoviesLoaded(
            popularMovies: moviesData,
          ),
        );
      });
    } catch (e) {
      emit(HomeMovieFailed(error: e.toString()));
    }
  }

  Future<void> onFetchTopRatedMovie(
      FetchTopRatedMoviesEvent event, emit) async {
    try {
      emit(HomeMovieLoading());

      final movies = await getTopRatedMovies.execute();

      movies.fold((error) {
        emit(
          HomeMovieFailed(
            error: error.message,
          ),
        );
      }, (moviesData) {
        emit(
          TopRatedMoviesLoaded(
            topRatedMovies: moviesData,
          ),
        );
      });
    } catch (e) {
      emit(HomeMovieFailed(error: e.toString()));
    }
  }
}
