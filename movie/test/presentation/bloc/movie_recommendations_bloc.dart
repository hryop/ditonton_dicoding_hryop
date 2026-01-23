import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecase/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';

import 'movie_recommendations_bloc.mocks.dart';


@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsBloc movieRecommendationsBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsBloc = MovieRecommendationsBloc(
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  final tId = 1;
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
    voteCount: 1, video: null,
  );
  final tMovieList = <Movie>[tMovie];

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    "should change movies data when data is gotten successfully",
    build: () {
      when(
        mockGetMovieRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tMovieList));

      return movieRecommendationsBloc;
    },
    act: (bloc) {
      bloc.add(OnGetMoviesRecommendationsEvent(tId));
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <MovieRecommendationsState>[
      GetMoviesRecommendationsLoadingState(),
      GetMoviesRecommendationsHasDataState(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}
