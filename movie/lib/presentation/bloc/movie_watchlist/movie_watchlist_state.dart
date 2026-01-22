part of 'movie_watchlist_bloc.dart';

class MovieWatchlistState extends Equatable{
  const MovieWatchlistState();

  @override
  List<Object?> get props => [];

}

//watchlist status
class GetMovieWatchlistStatusLoadingState extends MovieWatchlistState {}

class GetMovieWatchlistStatusResultState extends MovieWatchlistState {
  final bool result;

  const GetMovieWatchlistStatusResultState(this.result);

  @override
  List<Object?> get props => [result];
}

//save watchlist
class SaveMovieWatchlistSuccessState extends MovieWatchlistState {
  final String saveSuccessMessage;

  const SaveMovieWatchlistSuccessState(this.saveSuccessMessage);

  @override
  List<Object?> get props => [saveSuccessMessage];
}

class SaveMovieWatchlistErrorState extends MovieWatchlistState {
  final String saveErrorMessage;

  const SaveMovieWatchlistErrorState(this.saveErrorMessage);

  @override
  List<Object?> get props => [saveErrorMessage];
}

//remove watchlist
class RemoveMovieWatchlistSuccessState extends MovieWatchlistState {
  final String removeSuccessMessage;

  const RemoveMovieWatchlistSuccessState(this.removeSuccessMessage);

  @override
  List<Object?> get props => [removeSuccessMessage];
}

class RemoveMovieWatchlistErrorState extends MovieWatchlistState {
  final String removeErrorMessage;

  const RemoveMovieWatchlistErrorState(this.removeErrorMessage);

  @override
  List<Object?> get props => [removeErrorMessage];
}