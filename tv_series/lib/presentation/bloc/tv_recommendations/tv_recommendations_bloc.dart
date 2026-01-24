import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecase/get_tv_series_recommendations.dart';

part 'tv_recommendations_event.dart';

part 'tv_recommendations_state.dart';

class TVRecommendationsBloc
    extends Bloc<TVRecommendationsEvent, TVRecommendationsState> {
  final GetTVSeriesRecommendations getTVSeriesRecommendations;

  TVRecommendationsBloc(this.getTVSeriesRecommendations)
    : super(GetTVSeriesRecommendationsLoadingState()) {
    on<OnGetTVSeriesRecommendationsEvent>(_onGetTVSeriesRecommendationsEvent);
  }

  Future<void> _onGetTVSeriesRecommendationsEvent(
    OnGetTVSeriesRecommendationsEvent event,
    Emitter<TVRecommendationsState> emit,
  ) async {
    emit(GetTVSeriesRecommendationsLoadingState());

    final result = await getTVSeriesRecommendations.execute(event.id);
    result.fold(
      (failure) {
        emit(GetTVSeriesRecommendationsErrorState(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(GetTVSeriesRecommendationsEmptyState());
        } else {
          emit(GetTVSeriesRecommendationsHasDataState(data));
        }
      },
    );
  }

}
