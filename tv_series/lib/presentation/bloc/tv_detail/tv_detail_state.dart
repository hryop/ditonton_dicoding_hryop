part of 'tv_detail_bloc.dart';

class TVDetailState extends Equatable {
  const TVDetailState();

  @override
  List<Object?> get props => [];
}

//detail
class GetTVSeriesDetailLoadingState extends TVDetailState {}

class GetTVSeriesDetailHasDataState extends TVDetailState {
  final TvSeriesDetail result;

  const GetTVSeriesDetailHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class GetTVSeriesDetailErrorState extends TVDetailState {
  final String message;

  const GetTVSeriesDetailErrorState(this.message);

  @override
  List<Object?> get props => [message];
}


//watchlist status
class GetTvWatchlistStatusLoadingState extends TVDetailState {
}

class GetTvWatchlistStatusResultState extends TVDetailState {
  final bool result;

  const GetTvWatchlistStatusResultState(this.result);

  @override
  List<Object?> get props => [result];

}


//save watchlist
class SaveTvWatchlistSuccessState extends TVDetailState {
  final String message;

  const SaveTvWatchlistSuccessState(this.message);

  @override
  List<Object?> get props => [message];

}

class SaveTvWatchlistErrorState extends TVDetailState {
  final String message;

  const SaveTvWatchlistErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

//remove watchlist
class RemoveTvWatchlistSuccessState extends TVDetailState {
  final String message;

  const RemoveTvWatchlistSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class RemoveTvWatchlistErrorState extends TVDetailState {
  final String message;

  const RemoveTvWatchlistErrorState(this.message);

  @override
  List<Object?> get props => [message];

}
