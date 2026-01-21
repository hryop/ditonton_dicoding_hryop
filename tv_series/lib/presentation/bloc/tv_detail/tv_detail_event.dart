part of 'tv_detail_bloc.dart';

abstract class TVDetailEvent extends Equatable {
  const TVDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnGetTvSeriesDetailEvent extends TVDetailEvent {
  final int id;

  const OnGetTvSeriesDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class OnGetTvWatchlistStatusEvent extends TVDetailEvent {
  final int id;

  const OnGetTvWatchlistStatusEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class OnSaveTvWatchlistEvent extends TVDetailEvent {
  final TvSeriesDetail detail;

  const OnSaveTvWatchlistEvent(this.detail);

  @override
  List<Object?> get props => [detail];
}

class OnRemoveTvWatchlistEvent extends TVDetailEvent {
  final TvSeriesDetail detail;

  const OnRemoveTvWatchlistEvent(this.detail);

  @override
  List<Object?> get props => [detail];

}
