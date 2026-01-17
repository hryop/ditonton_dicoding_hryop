part of 'search_tv_series_bloc.dart';

class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();

  @override
  List<Object?> get props => [];
}

class SearchTvSeriesEmptyState extends SearchTvSeriesState {}

class SearchTvSeriesLoadingState extends SearchTvSeriesState {}

class SearchTvSeriesErrorState extends SearchTvSeriesState {
  final String message;

  const SearchTvSeriesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchTvSeriesHasDataState extends SearchTvSeriesState {
  final List<TVSeries> result;

  const SearchTvSeriesHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}
