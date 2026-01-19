part of 'tv_list_bloc.dart';

class TVListState extends Equatable{
  const TVListState();

  @override
  List<Object?> get props => [];

}

final class AiringTodayTVSeriesLoadingState extends TVListState {}
final class AiringTodayTVSeriesEmptyState extends TVListState {}
final class AiringTodayTVSeriesHasDataState extends TVListState {
  final List<TVSeries> result;

  const AiringTodayTVSeriesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
final class AiringTodayTVSeriesErrorState extends TVListState {
  final String message;

  const AiringTodayTVSeriesErrorState(this.message);

  @override
  List<Object?> get props => [message];

}

final class PopularTVSeriesLoadingState extends TVListState {}
final class PopularTVSeriesEmptyState extends TVListState {}
final class PopularTVSeriesHasDataState extends TVListState {
  final List<TVSeries> result;

  const PopularTVSeriesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
final class PopularTVSeriesErrorState extends TVListState {
  final String message;
  const PopularTVSeriesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

final class TopRatedTVSeriesLoadingState extends TVListState {}
final class TopRatedTVSeriesEmptyState extends TVListState {}
final class TopRatedTVSeriesHasDataState extends TVListState {
  final List<TVSeries> result;

  const TopRatedTVSeriesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
final class TopRatedTVSeriesErrorState extends TVListState {
  final String message;
  const TopRatedTVSeriesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
