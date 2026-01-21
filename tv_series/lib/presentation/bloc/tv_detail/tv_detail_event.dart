part of 'tv_detail_bloc.dart';

abstract class TVDetailEvent extends Equatable {
  const TVDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnGetTvSeriesDetailEvent extends TVDetailEvent {
  final int id;

  const OnGetTvSeriesDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}
