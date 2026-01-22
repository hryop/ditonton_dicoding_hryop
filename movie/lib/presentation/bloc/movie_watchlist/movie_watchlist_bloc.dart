import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecase/get_watchlist_status.dart';
import 'package:movie/domain/usecase/remove_watchlist.dart';
import 'package:movie/domain/usecase/save_movie_watchlist.dart';

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

  Future<void> _onGetTvWatchlistStatusEvent(event, emit) async{
    emit(GetMovieWatchlistStatusLoadingState());

    final result = await getWatchListStatus.execute(event.id);

    emit(GetMovieWatchlistStatusResultState(result));
  }

  Future<void> _onSaveMovieWatchlistEvent(event, emit) async{
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

  Future<void> _onRemoveMovieWatchlistEvent(event, emit) async{
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
