import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecase/get_movie_recommendations.dart';

part 'movie_recommendations_event.dart';

part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc
    extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationsBloc({required this.getMovieRecommendations})
    : super(GetMoviesRecommendationsLoadingState()) {
    on<OnGetMoviesRecommendationsEvent>(_onGetMoviesRecommendationsEvent);
  }

  Future<void> _onGetMoviesRecommendationsEvent(
    OnGetMoviesRecommendationsEvent event,
    Emitter<MovieRecommendationsState> emit,
  ) async {
    emit(GetMoviesRecommendationsLoadingState());

    final result = await getMovieRecommendations.execute(event.id);
    result.fold(
      (failure) {
        emit(GetMoviesRecommendationsErrorState(failure.message));
      },
      (data) {
        if (data.isEmpty) {
          emit(GetMoviesRecommendationsEmptyState());
        } else {
          emit(GetMoviesRecommendationsHasDataState(data));
        }
      },
    );
  }
}
