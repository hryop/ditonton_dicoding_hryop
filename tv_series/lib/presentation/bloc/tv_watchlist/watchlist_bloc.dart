import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecase/usecase_watchlist.dart';

part 'watchlist_event.dart';

part 'watchlist_state.dart';

class TVWatchlistBloc extends Bloc<TVWatchlistEvent, TVWatchlistState> {
  final GetTVWatchlistStatus getTVWatchListStatus;
  final SaveTVWatchlist saveTVWatchlist;
  final RemoveTVWatchlist removeTVWatchlist;

  TVWatchlistBloc({
    required this.removeTVWatchlist,
    required this.saveTVWatchlist,
    required this.getTVWatchListStatus,
  }) : super(GetTVWatchlistStatusLoadingState()) {
    on<OnGetTVWatchlistStatusEvent>(_onGetTVWatchlistStatusEvent);
    on<OnSaveTVWatchlistEvent>(_onSaveTVWatchlistEvent);
    on<OnRemoveTVWatchlistEvent>(_onRemoveTVWatchlistEvent);
  }

  Future<void> _onGetTVWatchlistStatusEvent(
    OnGetTVWatchlistStatusEvent event,
    Emitter<TVWatchlistState> emit,
  ) async {
    emit(GetTVWatchlistStatusLoadingState());

    final result = await getTVWatchListStatus.execute(event.id);

    emit(GetTVWatchlistStatusResultState(result));
  }

  Future<void> _onSaveTVWatchlistEvent(
    OnSaveTVWatchlistEvent event,
    Emitter<TVWatchlistState> emit,
  ) async {
    final result = await saveTVWatchlist.execute(event.detail);

    result.fold(
      (failure) {
        emit(SaveTVWatchlistErrorState(failure.message));
      },
      (data) {
        emit(SaveTVWatchlistSuccessState(data));
      },
    );
  }

  Future<void> _onRemoveTVWatchlistEvent(
    OnRemoveTVWatchlistEvent event,
    Emitter<TVWatchlistState> emit,
  ) async {
    final result = await removeTVWatchlist.execute(event.detail);

    result.fold(
      (failure) {
        emit(RemoveTVWatchlistErrorState(failure.message));
      },
      (data) {
        emit(RemoveTVWatchlistSuccessState(data));
      },
    );
  }
}
