part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

//detail
class GetMovieDetailLoadingState extends MovieDetailState {}

class GetMovieDetailHasDataState extends MovieDetailState {
  final MovieDetail result;

  const GetMovieDetailHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class GetMovieDetailErrorState extends MovieDetailState {
  final String message;

  const GetMovieDetailErrorState(this.message);

  @override
  List<Object?> get props => [message];
}