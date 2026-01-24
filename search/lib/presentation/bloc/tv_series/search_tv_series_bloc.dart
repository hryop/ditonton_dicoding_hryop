import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_tv_series.dart';

part 'search_tv_series_event.dart';

part 'search_tv_series_state.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTvSeries _searchTvSeries;

  SearchTvSeriesBloc(this._searchTvSeries) : super(SearchTvSeriesEmptyState()) {
    on<OnQueryTVSeriesChanged>(
      _onQueryTVSeriesChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onQueryTVSeriesChanged(OnQueryTVSeriesChanged event, Emitter<SearchTvSeriesState> emit) async{
    emit(SearchTvSeriesLoadingState());

    final String query = event.query;
    if (query.isEmpty) emit(SearchTvSeriesEmptyState());

    final result = await _searchTvSeries.execute(query);

    result.fold(
          (failure) {
        emit(SearchTvSeriesErrorState(failure.message));
      },
          (data) {
        if (data.isEmpty) {
          emit(SearchTvSeriesEmptyState());
        } else {
          emit(SearchTvSeriesHasDataState(data));
        }
      },
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
