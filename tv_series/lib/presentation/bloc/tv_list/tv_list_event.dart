part of 'tv_list_bloc.dart';

abstract class TVListEvent extends Equatable {
  const TVListEvent();

  @override
  List<Object?> get props => [];
}

class OnGetAiringTodayTVSeries extends TVListEvent {}

class OnGetPopularAiringTVSeries extends TVListEvent {}

class OnGetTopRatedTVSeries extends TVListEvent {}
