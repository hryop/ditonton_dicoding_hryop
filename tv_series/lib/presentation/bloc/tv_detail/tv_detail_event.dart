part of 'tv_detail_bloc.dart';

abstract class TVDetailEvent extends Equatable {
  const TVDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnGetTVSeriesDetailEvent extends TVDetailEvent {
  final int id;

  const OnGetTVSeriesDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}
