part of 'tv_detail_bloc.dart';

class TVDetailState extends Equatable {
  const TVDetailState();

  @override
  List<Object?> get props => [];
}

//detail
class GetTVSeriesDetailLoadingState extends TVDetailState {}

class GetTVSeriesDetailHasDataState extends TVDetailState {
  final TVSeriesDetail result;

  const GetTVSeriesDetailHasDataState(this.result);

  @override
  List<Object?> get props => [result];
}

class GetTVSeriesDetailErrorState extends TVDetailState {
  final String message;

  const GetTVSeriesDetailErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
