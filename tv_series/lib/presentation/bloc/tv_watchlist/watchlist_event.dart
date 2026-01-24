part of 'watchlist_bloc.dart';

abstract class TVWatchlistEvent extends Equatable{
  const TVWatchlistEvent();
  
  @override
  List<Object?> get props => [];
  
}

class OnGetTVWatchlistStatusEvent extends TVWatchlistEvent {
  final int id;

  const OnGetTVWatchlistStatusEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class OnSaveTVWatchlistEvent extends TVWatchlistEvent {
  final TVSeriesDetail detail;

  const OnSaveTVWatchlistEvent(this.detail);

  @override
  List<Object?> get props => [detail];
}

class OnRemoveTVWatchlistEvent extends TVWatchlistEvent {
  final TVSeriesDetail detail;

  const OnRemoveTVWatchlistEvent(this.detail);

  @override
  List<Object?> get props => [detail];

}