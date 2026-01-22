part of 'movie_list_bloc.dart';

class MovieListState extends Equatable{
  const MovieListState();

  @override
  List<Object?> get props => [];

}

final class NowPlayingMoviesLoadingState extends MovieListState {}
final class NowPlayingMoviesEmptyState extends MovieListState {}
final class NowPlayingMoviesHasDataState extends MovieListState {
  final List<Movie> result;

  const NowPlayingMoviesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
final class NowPlayingMoviesErrorState extends MovieListState {
  final String message;

  const NowPlayingMoviesErrorState(this.message);

  @override
  List<Object?> get props => [message];

}

final class PopularMoviesLoadingState extends MovieListState {}
final class PopularMoviesEmptyState extends MovieListState {}
final class PopularMoviesHasDataState extends MovieListState {
  final List<Movie> result;

  const PopularMoviesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
final class PopularMoviesErrorState extends MovieListState {
  final String message;
  const PopularMoviesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

final class TopRatedMoviesLoadingState extends MovieListState {}
final class TopRatedMoviesEmptyState extends MovieListState {}
final class TopRatedMoviesHasDataState extends MovieListState {
  final List<Movie> result;

  const TopRatedMoviesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
final class TopRatedMoviesErrorState extends MovieListState {
  final String message;
  const TopRatedMoviesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

