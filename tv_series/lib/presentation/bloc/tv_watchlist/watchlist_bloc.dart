import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecase/get_tv_watchlist_status.dart';
import 'package:tv_series/domain/usecase/remove_tv_watchlist.dart';
import 'package:tv_series/domain/usecase/save_tv_watchlist.dart';

part 'watchlist_event.dart';

part 'watchlist_state.dart';

class TVWatchlistBloc extends Bloc<TVWatchlistEvent, TVWatchlistState> {
  final GetTvWatchlistStatus getTvWatchListStatus;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;

  TVWatchlistBloc({
    required this.removeTvWatchlist,
    required this.saveTvWatchlist,
    required this.getTvWatchListStatus,
  }) : super(GetTvWatchlistStatusLoadingState()) {
    on<OnGetTvWatchlistStatusEvent>(_onGetTvWatchlistStatusEvent);
    on<OnSaveTvWatchlistEvent>(_onSaveTvWatchlistEvent);
    on<OnRemoveTvWatchlistEvent>(_onRemoveTvWatchlistEvent);
  }

  Future<void> _onGetTvWatchlistStatusEvent(
    OnGetTvWatchlistStatusEvent event,
    Emitter<TVWatchlistState> emit,
  ) async {
    emit(GetTvWatchlistStatusLoadingState());

    final result = await getTvWatchListStatus.execute(event.id);

    emit(GetTvWatchlistStatusResultState(result));
  }

  Future<void> _onSaveTvWatchlistEvent(
    OnSaveTvWatchlistEvent event,
    Emitter<TVWatchlistState> emit,
  ) async {
    final result = await saveTvWatchlist.execute(event.detail);

    result.fold(
      (failure) {
        SaveTvWatchlistErrorState(failure.message);
      },
      (data) {
        SaveTvWatchlistErrorState(data);
      },
    );
  }

  Future<void> _onRemoveTvWatchlistEvent(
    OnRemoveTvWatchlistEvent event,
    Emitter<TVWatchlistState> emit,
  ) async {
    final result = await removeTvWatchlist.execute(event.detail);

    result.fold(
      (failure) {
        RemoveTvWatchlistErrorState(failure.message);
      },
      (data) {
        RemoveTvWatchlistSuccessState(data);
      },
    );
  }
}
