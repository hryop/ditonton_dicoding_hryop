import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecase/usecase_movie_watchlist.dart';

part 'movie_watchlist_event.dart';

part 'movie_watchlist_state.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveMovieWatchlist saveMovieWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieWatchlistBloc({
    required this.getWatchListStatus,
    required this.saveMovieWatchlist,
    required this.removeWatchlist,
  }) : super(GetMovieWatchlistStatusLoadingState()) {
    on<OnGetTvWatchlistStatusEvent>(_onGetTvWatchlistStatusEvent);
    on<OnSaveMovieWatchlistEvent>(_onSaveMovieWatchlistEvent);
    on<OnRemoveMovieWatchlistEvent>(_onRemoveMovieWatchlistEvent);
  }

  Future<void> _onGetTvWatchlistStatusEvent(
    OnGetTvWatchlistStatusEvent event,
    Emitter<MovieWatchlistState> emit,
  ) async {
    emit(GetMovieWatchlistStatusLoadingState());

    final result = await getWatchListStatus.execute(event.id);

    emit(GetMovieWatchlistStatusResultState(result));
  }

  Future<void> _onSaveMovieWatchlistEvent(
    OnSaveMovieWatchlistEvent event,
    Emitter<MovieWatchlistState> emit,
  ) async {
    final result = await saveMovieWatchlist.execute(event.detail);

    result.fold(
      (failure) {
        emit(SaveMovieWatchlistErrorState(failure.message));
      },
      (data) {
        emit(SaveMovieWatchlistSuccessState(data));
      },
    );
  }

  Future<void> _onRemoveMovieWatchlistEvent(
    OnRemoveMovieWatchlistEvent event,
    Emitter<MovieWatchlistState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.detail);

    result.fold(
      (failure) {
        emit(RemoveMovieWatchlistErrorState(failure.message));
      },
      (data) {
        emit(RemoveMovieWatchlistSuccessState(data));
      },
    );
  }
}
