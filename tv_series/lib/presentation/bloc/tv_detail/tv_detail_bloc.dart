import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecase/usecase_detail.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvWatchlistStatus getTvWatchListStatus;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;

  TVDetailBloc({
    required this.getTvSeriesDetail,
    required this.getTvWatchListStatus,
    required this.saveTvWatchlist,
    required this.removeTvWatchlist,
  }) : super(GetTVSeriesDetailLoadingState()) {
    on<OnGetTvSeriesDetailEvent>(_onGetTvSeriesDetailEvent);
    on<OnGetTvWatchlistStatusEvent>(_onGetTvWatchlistStatusEvent);
    on<OnSaveTvWatchlistEvent>(_onSaveTvWatchlistEvent);
    on<OnRemoveTvWatchlistEvent>(_onRemoveTvWatchlistEvent);
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

  Future<void> _onGetTvWatchlistStatusEvent(OnGetTvWatchlistStatusEvent event, Emitter<TVDetailState> emit) async {
    emit(GetTvWatchlistStatusLoadingState());

    final result = await getTvWatchListStatus.execute(event.id);

    emit(GetTvWatchlistStatusResultState(result));
  }

  Future<void> _onSaveTvWatchlistEvent(OnSaveTvWatchlistEvent event, Emitter<TVDetailState> emit) async {
    final result = await saveTvWatchlist.execute(event.detail);

    result.fold(
      (failure) {
        SaveTvWatchlistErrorState(failure.message);
      },
      (data) {
        SaveTvWatchlistErrorState(data);
      },
    );
  }

  Future<void> _onRemoveTvWatchlistEvent(OnRemoveTvWatchlistEvent event, Emitter<TVDetailState> emit) async {
    final result = await saveTvWatchlist.execute(event.detail);

    result.fold(
      (failure) {
        RemoveTvWatchlistErrorState(failure.message);
      },
      (data) {
        RemoveTvWatchlistSuccessState(data);
      },
    );
  }
}
