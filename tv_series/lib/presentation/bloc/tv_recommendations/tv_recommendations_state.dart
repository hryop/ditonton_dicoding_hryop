part of 'tv_recommendations_bloc.dart';

class TVRecommendationsState extends Equatable{
  const TVRecommendationsState();

  @override
  List<Object?> get props => [];

}

class GetTVSeriesRecommendationsLoadingState extends TVRecommendationsState {}

class GetTVSeriesRecommendationsHasDataState extends TVRecommendationsState {
  final List<TVSeries> result;

  const GetTVSeriesRecommendationsHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class GetTVSeriesRecommendationsErrorState extends TVRecommendationsState {
  final String message;

  const GetTVSeriesRecommendationsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetTVSeriesRecommendationsEmptyState extends TVRecommendationsState {}
