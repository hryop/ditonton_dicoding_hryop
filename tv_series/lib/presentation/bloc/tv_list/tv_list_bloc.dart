import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecase/usecase_tv_list.dart';

part 'tv_list_event.dart';

part 'tv_list_state.dart';

class TVListBloc extends Bloc<TVListEvent, TVListState> {
  GetAiringTodayTvSeries getAiringTodayTvSeries;
  GetPopularTvSeries getPopularTvSeries;
  GetTopRatedTvSeries getTopRatedTvSeries;

  TVListBloc({
    required this.getAiringTodayTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  }) : super(AiringTodayTVSeriesLoadingState()) {
    on<OnGetAiringTodayTVSeries>(_onGetAiringTodayTvSeries);
    on<OnGetPopularAiringTVSeries>(_onGetPopularTvSeries);
    on<OnGetTopRatedTVSeries>(_onGetTopRatedTvSeries);
  }

  Future<void> _onGetAiringTodayTvSeries(
    OnGetAiringTodayTVSeries event,
    Emitter<TVListState> emit,
  ) async {
    emit(AiringTodayTVSeriesLoadingState());

    final result = await getAiringTodayTvSeries.execute();

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

  Future<void> _onGetPopularTvSeries(
    OnGetPopularAiringTVSeries event,
    Emitter<TVListState> emit,
  ) async {
    emit(PopularTVSeriesLoadingState());

    final result = await getPopularTvSeries.execute();

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

  Future<void> _onGetTopRatedTvSeries(
    OnGetTopRatedTVSeries event,
    Emitter<TVListState> emit,
  ) async {
    emit(TopRatedTVSeriesLoadingState());

    final result = await getTopRatedTvSeries.execute();

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
