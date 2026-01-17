part of 'watchlist_bloc.dart';

class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

final class WatchlistEmptyState extends WatchlistState {}

final class WatchlistLoadingState extends WatchlistState {}

final class WatchlistErrorState extends WatchlistState {
  final String message;

  const WatchlistErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

final class WatchlistHasDataState extends WatchlistState {
  final List<Watchlist> result;

  const WatchlistHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
