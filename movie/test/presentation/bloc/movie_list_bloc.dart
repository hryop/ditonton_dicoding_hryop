import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecase/get_now_playing_movies.dart';
import 'package:movie/domain/usecase/get_popular_movies.dart';
import 'package:movie/domain/usecase/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';

import 'movie_list_bloc.mocks.dart';

@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

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
    voteCount: 1, video: false,
  );
  final tMovieListList = <Movie>[tMovie];

  blocTest<MovieListBloc, MovieListState>(
    "should change movies data when data is gotten successfully",
    build: () {
      when(
        mockGetNowPlayingMovies.execute(),
      ).thenAnswer((_) async => Right(tMovieListList));

      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => Right(tMovieListList));

      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => Right(tMovieListList));

      return movieListBloc;
    },
    act: (bloc) {
      bloc.add(OnGetNowPlayingMovies());
      bloc.add(OnGetPopularMoies());
      bloc.add(OnGetTopRatedMovies());
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <MovieListState>[
      NowPlayingMoviesLoadingState(),
      NowPlayingMoviesHasDataState(tMovieListList),
      PopularMoviesLoadingState(),
      PopularMoviesHasDataState(tMovieListList),
      TopRatedMoviesLoadingState(),
      TopRatedMoviesHasDataState(tMovieListList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
      verify(mockGetPopularMovies.execute());
      verify(mockGetPopularMovies.execute());
    },
  );
}
