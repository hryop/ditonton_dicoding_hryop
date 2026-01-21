part of 'watchlist_bloc.dart';

class TVWatchlistState extends Equatable {
  const TVWatchlistState();

  @override
  List<Object?> get props => [];
}

//watchlist status
class GetTvWatchlistStatusLoadingState extends TVWatchlistState {}

class GetTvWatchlistStatusResultState extends TVWatchlistState {
  final bool result;

  const GetTvWatchlistStatusResultState(this.result);

  @override
  List<Object?> get props => [result];
}

//save watchlist
class SaveTvWatchlistSuccessState extends TVWatchlistState {
  final String saveSuccessMessage;

  const SaveTvWatchlistSuccessState(this.saveSuccessMessage);

  @override
  List<Object?> get props => [saveSuccessMessage];
}

class SaveTvWatchlistErrorState extends TVWatchlistState {
  final String saveErrorMessage;

  const SaveTvWatchlistErrorState(this.saveErrorMessage);

  @override
  List<Object?> get props => [saveErrorMessage];
}

//remove watchlist
class RemoveTvWatchlistSuccessState extends TVWatchlistState {
  final String removeSuccessMessage;

  const RemoveTvWatchlistSuccessState(this.removeSuccessMessage);

  @override
  List<Object?> get props => [removeSuccessMessage];
}

class RemoveTvWatchlistErrorState extends TVWatchlistState {
  final String removeErrorMessage;

  const RemoveTvWatchlistErrorState(this.removeErrorMessage);

  @override
  List<Object?> get props => [removeErrorMessage];
}
