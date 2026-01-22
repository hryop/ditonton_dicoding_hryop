import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecase/get_movie_detail.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(GetMovieDetailLoadingState()) {
    on<OnGetMovieDetailEvent>(_onGetMovieDetailEvent);
  }

  Future<void> _onGetMovieDetailEvent(event, emit) async{
    emit(GetMovieDetailLoadingState());

    final result = await getMovieDetail.execute(event.id);
    result.fold(
          (failure) {
        emit(GetMovieDetailErrorState(failure.message));
      },
          (data) {
        emit(GetMovieDetailHasDataState(data));
      },
    );
  }
}
