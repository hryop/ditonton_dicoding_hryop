import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecase/get_movie_detail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
  });

  final tId = 1;

  blocTest<MovieDetailBloc, MovieDetailState>(
    "should change tv seriesdetail data when data is gotten successfully",
    build: (){
      when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => Right(testMovieDetail),
      );

      return movieDetailBloc;
    },
    act: (bloc)=>bloc.add(OnGetMovieDetailEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => <MovieDetailState>[
      GetMovieDetailLoadingState(),
      GetMovieDetailHasDataState(testMovieDetail)
    ],
    verify: (bloc){
      verify(mockGetMovieDetail.execute(tId));
    }
  );
}
