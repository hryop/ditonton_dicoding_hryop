part of 'tv_recommendations_bloc.dart';

abstract class TVRecommendationsEvent extends Equatable {
  const TVRecommendationsEvent();

  @override
  List<Object?> get props => [];
}

class OnGetTvSeriesRecommendationsEvent extends TVRecommendationsEvent {
  final int id;

  const OnGetTvSeriesRecommendationsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
