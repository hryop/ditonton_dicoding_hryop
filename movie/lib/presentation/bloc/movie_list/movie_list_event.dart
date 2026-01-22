part of 'movie_list_bloc.dart';

abstract class MovieListEvent {}

class OnGetNowPlayingMovies extends MovieListEvent {}

class OnGetPopularMoies extends MovieListEvent {}

class OnGetTopRatedMovies extends MovieListEvent {}