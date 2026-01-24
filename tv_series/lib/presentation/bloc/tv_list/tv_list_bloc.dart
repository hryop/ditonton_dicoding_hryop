import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecase/usecase_tv_list.dart';

part 'tv_list_event.dart';

part 'tv_list_state.dart';

class TVListBloc extends Bloc<TVListEvent, TVListState> {
  GetAiringTodayTVSeries getAiringTodayTVSeries;
  GetPopularTVSeries getPopularTVSeries;
  GetTopRatedTVSeries getTopRatedTVSeries;

  TVListBloc({
    required this.getAiringTodayTVSeries,
    required this.getPopularTVSeries,
    required this.getTopRatedTVSeries,
  }) : super(AiringTodayTVSeriesLoadingState()) {
    on<OnGetAiringTodayTVSeries>(_onGetAiringTodayTVSeries);
    on<OnGetPopularAiringTVSeries>(_onGetPopularTVSeries);
    on<OnGetTopRatedTVSeries>(_onGetTopRatedTVSeries);
  }

  Future<void> _onGetAiringTodayTVSeries(
    OnGetAiringTodayTVSeries event,
    Emitter<TVListState> emit,
  ) async {
    emit(AiringTodayTVSeriesLoadingState());

    final result = await getAiringTodayTVSeries.execute();

    result.fold(
      (failure) {
        emit(AiringTodayTVSeriesErrorState(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(AiringTodayTVSeriesEmptyState());
        } else {
          emit(AiringTodayTVSeriesHasDataState(data));
        }
      },
    );
  }

  Future<void> _onGetPopularTVSeries(
    OnGetPopularAiringTVSeries event,
    Emitter<TVListState> emit,
  ) async {
    emit(PopularTVSeriesLoadingState());

    final result = await getPopularTVSeries.execute();

    result.fold(
      (failure) {
        emit(PopularTVSeriesErrorState(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(PopularTVSeriesEmptyState());
        } else {
          emit(PopularTVSeriesHasDataState(data));
        }
      },
    );
  }

  Future<void> _onGetTopRatedTVSeries(
    OnGetTopRatedTVSeries event,
    Emitter<TVListState> emit,
  ) async {
    emit(TopRatedTVSeriesLoadingState());

    final result = await getTopRatedTVSeries.execute();

    result.fold(
      (failure) {
        emit(TopRatedTVSeriesErrorState(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(TopRatedTVSeriesEmptyState());
        } else {
          emit(TopRatedTVSeriesHasDataState(data));
        }
      },
    );
  }
}
