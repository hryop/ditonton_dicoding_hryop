import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/presentation/widgets/empty_result_widget.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:core/core.dart';

import 'movie_detail_page.dart';

class HomeMoviePageContent extends StatefulWidget {
  const HomeMoviePageContent({super.key});

  @override
  HomeMoviePageContentState createState() => HomeMoviePageContentState();
}

class HomeMoviePageContentState extends State<HomeMoviePageContent> {
  List<Movie> nowPlaying = [];
  String nowPlayingMessage = "";
  List<Movie> popular = [];
  String popularMessage = "";
  List<Movie> topRated = [];
  String topRatedMessage = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<MovieListBloc>()
          ..add(OnGetNowPlayingMovies())
          ..add(OnGetPopularMoies())
          ..add(OnGetTopRatedMovies());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Now Playing', style: heading6),
            BlocConsumer<MovieListBloc, MovieListState>(
              listener: (context, state) {
                if (state is NowPlayingMoviesHasDataState) {
                  nowPlaying = state.result;
                } else if (state is NowPlayingMoviesErrorState) {
                  nowPlaying = [];
                  nowPlayingMessage = state.message;
                } else if (state is NowPlayingMoviesEmptyState) {
                  nowPlaying = [];
                  nowPlayingMessage = "There isn't any tv series airing today";
                }
              },
              builder: (context, state) {
                if (state is NowPlayingMoviesLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                if (nowPlaying.isEmpty) {
                  return EmptyResultWidget(nowPlayingMessage);
                } else {
                  return MovieListWidget(nowPlaying);
                }
              },
            ),
            SubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.routeName),
            ),
            BlocConsumer<MovieListBloc, MovieListState>(
              listener: (context, state) {
                if (state is PopularMoviesHasDataState) {
                  popular = state.result;
                } else if (state is PopularMoviesErrorState) {
                  popular = [];
                  popularMessage = state.message;
                } else if (state is PopularMoviesEmptyState) {
                  popular = [];
                  popularMessage = "There isn't any popular tv series";
                }
              },
              builder: (context, state) {
                if (state is PopularMoviesLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                if (popular.isEmpty) {
                  return EmptyResultWidget(popularMessage);
                } else {
                  return MovieListWidget(popular);
                }
              },
            ),
            SubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
            ),
            BlocConsumer<MovieListBloc, MovieListState>(
              listener: (context, state) {
                if (state is TopRatedMoviesHasDataState) {
                  topRated = state.result;
                } else if (state is TopRatedMoviesErrorState) {
                  topRated = [];
                  topRatedMessage = state.message;
                } else if (state is TopRatedMoviesEmptyState) {
                  topRated = [];
                  topRatedMessage = "There isn't any top rated tv series";
                }
              },
              builder: (context, state) {
                if (state is TopRatedMoviesLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                if (topRated.isEmpty) {
                  return EmptyResultWidget(topRatedMessage);
                } else {
                  return MovieListWidget(topRated);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MovieListWidget extends StatelessWidget {
  final List<Movie> movies;

  const MovieListWidget(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageURL${movie.posterPath}',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
