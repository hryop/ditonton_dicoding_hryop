part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

//detail
class GetMovieLoadingState extends MovieDetailState {}

class GetMovieHasDataState extends MovieDetailState {
  final MovieDetail result;

  const GetMovieHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class GetMovieErrorState extends MovieDetailState {
  final String message;

  const GetMovieErrorState(this.message);

  @override
  List<Object?> get props => [message];
}