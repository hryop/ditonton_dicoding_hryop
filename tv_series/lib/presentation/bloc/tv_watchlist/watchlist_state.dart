part of 'watchlist_bloc.dart';

class TVWatchlistState extends Equatable {
  const TVWatchlistState();

  @override
  List<Object?> get props => [];
}

//watchlist status
class GetTVWatchlistStatusLoadingState extends TVWatchlistState {}

class GetTVWatchlistStatusResultState extends TVWatchlistState {
  final bool result;

  const GetTVWatchlistStatusResultState(this.result);

  @override
  List<Object?> get props => [result];
}

//save watchlist
class SaveTVWatchlistSuccessState extends TVWatchlistState {
  final String saveSuccessMessage;

  const SaveTVWatchlistSuccessState(this.saveSuccessMessage);

  @override
  List<Object?> get props => [saveSuccessMessage];
}

class SaveTVWatchlistErrorState extends TVWatchlistState {
  final String saveErrorMessage;

  const SaveTVWatchlistErrorState(this.saveErrorMessage);

  @override
  List<Object?> get props => [saveErrorMessage];
}

//remove watchlist
class RemoveTVWatchlistSuccessState extends TVWatchlistState {
  final String removeSuccessMessage;

  const RemoveTVWatchlistSuccessState(this.removeSuccessMessage);

  @override
  List<Object?> get props => [removeSuccessMessage];
}

class RemoveTVWatchlistErrorState extends TVWatchlistState {
  final String removeErrorMessage;

  const RemoveTVWatchlistErrorState(this.removeErrorMessage);

  @override
  List<Object?> get props => [removeErrorMessage];
}
