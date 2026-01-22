import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecase/get_now_playing_movies.dart';
import 'package:movie/domain/usecase/get_popular_movies.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';

part 'movie_list_event.dart';

part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(NowPlayingMoviesEmptyState()) {
    on<OnGetNowPlayingMovies>(_onGetNowPlayingMovies);
    on<OnGetPopularMoies>(_onGetPopularMoies);
    on<OnGetTopRatedMovies>(_onGetTopRatedMovies);
  }

  Future<void> _onGetNowPlayingMovies(event, emit) async {
    emit(NowPlayingMoviesLoadingState());

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(NowPlayingMoviesErrorState(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(NowPlayingMoviesEmptyState());
        } else {
          emit(NowPlayingMoviesHasDataState(data));
        }
      },
    );
  }

  Future<void> _onGetPopularMoies(event, emit) async {
    emit(PopularMoviesLoadingState());

    final result = await getPopularMovies.execute();

    result.fold(
          (failure) {
        emit(PopularMoviesErrorState(failure.message));
      },
          (data) {
        if (data.isEmpty) {
          emit(PopularMoviesEmptyState());
        } else {
          emit(PopularMoviesHasDataState(data));
        }
      },
    );
  }

  Future<void> _onGetTopRatedMovies(event, emit) async {
    emit(TopRatedMoviesLoadingState());

    final result = await getTopRatedMovies.execute();

    result.fold(
          (failure) {
        emit(TopRatedMoviesErrorState(failure.message));
      },
          (data) {
        if (data.isEmpty) {
          emit(TopRatedMoviesEmptyState());
        } else {
          emit(TopRatedMoviesHasDataState(data));
        }
      },
    );
  }
}
