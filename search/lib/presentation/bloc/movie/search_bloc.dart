import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_movies.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;

  SearchBloc(this._searchMovies) : super(SearchEmptyState()) {
    on<OnQueryChanged>(
      _onQueryChanged,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _onQueryChanged(
    OnQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());

    final String query = event.query;
    if (query.isEmpty) emit(SearchEmptyState());

    final result = await _searchMovies.execute(query);

    result.fold(
      (failure) {
        emit(SearchErrorState(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(SearchEmptyState());
        } else {
          emit(SearchHasDataState(data));
        }
      },
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
