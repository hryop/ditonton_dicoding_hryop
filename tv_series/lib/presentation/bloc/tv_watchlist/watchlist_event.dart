part of 'watchlist_bloc.dart';

class TVWatchlistEvent extends Equatable{
  const TVWatchlistEvent();
  
  @override
  List<Object?> get props => [];
  
}

class OnGetTvWatchlistStatusEvent extends TVWatchlistEvent {
  final int id;

  const OnGetTvWatchlistStatusEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class OnSaveTvWatchlistEvent extends TVWatchlistEvent {
  final TvSeriesDetail detail;

  const OnSaveTvWatchlistEvent(this.detail);

  @override
  List<Object?> get props => [detail];
}

class OnRemoveTvWatchlistEvent extends TVWatchlistEvent {
  final TvSeriesDetail detail;

  const OnRemoveTvWatchlistEvent(this.detail);

  @override
  List<Object?> get props => [detail];

}