import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:core/presentation/widgets/empty_result_widget.dart';
import 'package:core/presentation/widgets/recommendation_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:core/core.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/movie_detail';

  final int id;

  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetail? movieDetail;
  String movieDetailMessage = '';
  bool isLoadingMovieDetail = true;

  bool isLoadingRecommendations = true;
  List<Movie> recommendations = [];
  String recommendationsMessage = '';

  bool isAddedWatchlist = false;
  String watchlistMessage = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(OnGetMovieDetailEvent(widget.id));
      context.read<MovieWatchlistBloc>().add(
        OnGetTvWatchlistStatusEvent(widget.id),
      );
      context.read<MovieRecommendationsBloc>().add(
        OnGetMoviesRecommendationsEvent(widget.id),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MovieDetailBloc, MovieDetailState>(
          listener: (context, state) {
            if (state is GetMovieDetailHasDataState) {
              movieDetail = state.result;
              isLoadingMovieDetail = false;
            } else if (state is GetMovieDetailErrorState) {
              movieDetailMessage = state.message.isEmpty
                  ? "Server error"
                  : state.message;
              isLoadingMovieDetail = false;
            }
          },
        ),
        BlocListener<MovieWatchlistBloc, MovieWatchlistState>(
          listener: (context, state) {
            if (state is GetMovieWatchlistStatusResultState) {
              isAddedWatchlist = state.result;
            } else if (state is SaveMovieWatchlistSuccessState) {
              isAddedWatchlist = true;
              watchlistMessage = state.saveSuccessMessage;

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(watchlistMessage)));
            } else if (state is SaveMovieWatchlistErrorState) {
              watchlistMessage = state.saveErrorMessage.isEmpty
                  ? "Server error"
                  : state.saveErrorMessage;

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(content: Text(watchlistMessage));
                },
              );
            } else if (state is RemoveMovieWatchlistSuccessState) {
              isAddedWatchlist = false;
              watchlistMessage = state.removeSuccessMessage;

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(watchlistMessage)));
            } else if (state is RemoveMovieWatchlistErrorState) {
              watchlistMessage = state.removeErrorMessage.isEmpty
                  ? "Server error"
                  : state.removeErrorMessage;

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(content: Text(watchlistMessage));
                },
              );
            }
          },
        ),
        BlocListener<MovieRecommendationsBloc, MovieRecommendationsState>(
          listener: (context, state) {
            if (state is GetMoviesRecommendationsLoadingState) {
              isLoadingRecommendations = true;
              recommendations = [];
            } else if (state is GetMoviesRecommendationsHasDataState) {
              isLoadingRecommendations = false;
              recommendations = state.result;
            } else if (state is GetMoviesRecommendationsErrorState) {
              isLoadingRecommendations = false;
              recommendations = [];
              recommendationsMessage = state.message.isEmpty
                  ? "Server error"
                  : state.message;
            } else if (state is GetMoviesRecommendationsEmptyState) {
              isLoadingRecommendations = false;
              recommendations = [];
              recommendationsMessage =
                  "There isn't any Movie series recommendations";
            }
          },
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (isLoadingMovieDetail) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is GetMovieDetailErrorState) {
              return EmptyResultWidget(movieDetailMessage);
            }

            return SafeArea(child: MovieDetailContent());
          },
        ),
      ),
    );
  }

  MovieDetailContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${movieDetail?.posterPath}',
          width: screenWidth,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: richBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(movieDetail?.title ?? "", style: heading5),
                            watchlistButton(),
                            Text(
                              movieDetail?.genres == null
                                  ? ""
                                  : _showGenres(movieDetail!.genres),
                            ),
                            Text(
                              movieDetail?.genres == null
                                  ? ""
                                  : _showDuration(movieDetail!.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: (movieDetail?.voteAverage ?? 0) / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      Icon(Icons.star, color: mikadoYellow),
                                  itemSize: 24,
                                ),
                                Text('${movieDetail?.voteAverage ?? 0}'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text('Overview', style: heading6),
                            Text(movieDetail?.overview ?? ""),
                            SizedBox(height: 16),
                            Text('Recommendations', style: heading6),
                            recommendationsWidget(),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: richBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget watchlistButton() {
    return BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
      builder: (context, state) {
        return FilledButton(
          onPressed: () async {
            if (movieDetail != null) {
              if (isAddedWatchlist) {
                context.read<MovieWatchlistBloc>().add(
                  OnRemoveMovieWatchlistEvent(movieDetail!),
                );
              } else {
                context.read<MovieWatchlistBloc>().add(
                  OnSaveMovieWatchlistEvent(movieDetail!),
                );
              }
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              isAddedWatchlist ? Icon(Icons.check) : Icon(Icons.add),
              Text('Watchlist'),
            ],
          ),
        );
      },
    );
  }

  Widget recommendationsWidget() {
    return BlocBuilder<MovieRecommendationsBloc, MovieRecommendationsState>(
      builder: (context, state) {
        if (isLoadingRecommendations) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (recommendations.isEmpty) {
          return EmptyResultWidget(recommendationsMessage);
        }

        return Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final tvRecommendation = recommendations[index];
              return RecommendationCard(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    MovieDetailPage.ROUTE_NAME,
                    arguments: tvRecommendation.id,
                  );
                },
                posterPath: tvRecommendation.posterPath ?? "",
              );
            },
            itemCount: recommendations.length,
          ),
        );
      },
    );
  }

  String _showGenres(List<Genre> genres) {
    if (genres.isEmpty) return '';
    return genres.map((e) => e.name).toList().join(',');
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
