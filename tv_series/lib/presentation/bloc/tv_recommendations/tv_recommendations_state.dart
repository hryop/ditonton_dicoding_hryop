part of 'tv_recommendations_bloc.dart';

class TVRecommendationsState extends Equatable{
  const TVRecommendationsState();

  @override
  List<Object?> get props => [];

}

class GetTvSeriesRecommendationsLoadingState extends TVRecommendationsState {}

class GetTvSeriesRecommendationsHasDataState extends TVRecommendationsState {
  final List<TVSeries> result;

  const GetTvSeriesRecommendationsHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class GetTvSeriesRecommendationsErrorState extends TVRecommendationsState {
  final String message;

  const GetTvSeriesRecommendationsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetTvSeriesRecommendationsEmptyState extends TVRecommendationsState {}
