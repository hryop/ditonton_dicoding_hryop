import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecase/get_tv_series_recommendations.dart';

part 'tv_recommendations_event.dart';

part 'tv_recommendations_state.dart';

class TVRecommendationsBloc
    extends Bloc<TVRecommendationsEvent, TVRecommendationsState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TVRecommendationsBloc(this.getTvSeriesRecommendations)
    : super(GetTvSeriesRecommendationsLoadingState()) {
    on<OnGetTvSeriesRecommendationsEvent>(_onGetTvSeriesRecommendationsEvent);
  }

  Future<void> _onGetTvSeriesRecommendationsEvent(
    OnGetTvSeriesRecommendationsEvent event,
    Emitter<TVRecommendationsState> emit,
  ) async {
    emit(GetTvSeriesRecommendationsLoadingState());

    final result = await getTvSeriesRecommendations.execute(event.id);
    result.fold(
      (failure) {
        emit(GetTvSeriesRecommendationsErrorState(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(GetTvSeriesRecommendationsEmptyState());
        } else {
          emit(GetTvSeriesRecommendationsHasDataState(data));
        }
      },
    );
  }

}
