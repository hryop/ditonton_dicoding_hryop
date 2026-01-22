part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable{
  const MovieWatchlistEvent();

  @override
  List<Object?> get props => [];

}

class OnGetTvWatchlistStatusEvent extends MovieWatchlistEvent {
  final int id;

  const OnGetTvWatchlistStatusEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class OnSaveMovieWatchlistEvent extends MovieWatchlistEvent {
  final MovieDetail detail;

  const OnSaveMovieWatchlistEvent(this.detail);

  @override
  List<Object?> get props => [detail];
}

class OnRemoveMovieWatchlistEvent extends MovieWatchlistEvent {
  final MovieDetail detail;

  const OnRemoveMovieWatchlistEvent(this.detail);

  @override
  List<Object?> get props => [detail];

}