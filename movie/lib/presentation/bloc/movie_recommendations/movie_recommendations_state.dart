part of 'movie_recommendations_bloc.dart';

class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();

  @override
  List<Object?> get props => [];

}

class GetMoviesRecommendationsLoadingState extends MovieRecommendationsState {}

class GetMoviesRecommendationsHasDataState extends MovieRecommendationsState {
  final List<Movie> result;

  const GetMoviesRecommendationsHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class GetMoviesRecommendationsErrorState extends MovieRecommendationsState {
  final String message;

  const GetMoviesRecommendationsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetMoviesRecommendationsEmptyState extends MovieRecommendationsState {}