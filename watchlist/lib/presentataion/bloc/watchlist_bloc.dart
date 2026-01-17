import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/domain/usecase/get_watchlist.dart';

part 'watchlist_event.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist _getWatchlist;

  WatchlistBloc(this._getWatchlist) : super(WatchlistEmptyState()) {
    on<WatchlistEvent>(_onGetWatchlist);
  }

  Future<void> _onGetWatchlist(event, emit) async {
    emit(WatchlistLoadingState());

    final result = await _getWatchlist.execute();

    result.fold(
      (failure) {
        emit(WatchlistErrorState(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(WatchlistEmptyState());
        } else {
          emit(WatchlistHasDataState(data));
        }
      },
    );
  }
}
