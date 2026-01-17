part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable{
  const WatchlistEvent();

  @override
  List<Object?> get props => [];
}

class OnGetWatchListEvent extends WatchlistEvent {
  const OnGetWatchListEvent();

  @override
  List<Object?> get props => [];
}
