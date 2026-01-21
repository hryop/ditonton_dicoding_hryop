import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecase/usecase_detail.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  TVDetailBloc({
    required this.getTvSeriesDetail,
  }) : super(GetTVSeriesDetailLoadingState()) {
    on<OnGetTvSeriesDetailEvent>(_onGetTvSeriesDetailEvent);
  }

  Future<void> _onGetTvSeriesDetailEvent( OnGetTvSeriesDetailEvent event, Emitter<TVDetailState> emit) async {
    emit(GetTVSeriesDetailLoadingState());

    final result = await getTvSeriesDetail.execute(event.id);
    result.fold(
      (failure) {
        emit(GetTVSeriesDetailErrorState(failure.message));
      },
      (data) {
        emit(GetTVSeriesDetailHasDataState(data));
      },
    );
  }
}
