import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:core/presentation/widgets/empty_result_widget.dart';
import 'package:core/presentation/widgets/recommendation_card.dart';
import 'package:core/presentation/widgets/season_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_watchlist/watchlist_bloc.dart';

class TVDetailPage extends StatefulWidget {
  static const routeName = '/tv_detail';

  final int id;

  const TVDetailPage({super.key, required this.id});

  @override
  TVDetailPageState createState() => TVDetailPageState();
}

class TVDetailPageState extends State<TVDetailPage> {
  TVSeriesDetail? tvDetail;
  String tvDetailMessage = '';
  bool isLoadingTVDetail = true;

  bool isLoadingRecommendations = true;
  List<TVSeries> recommendations = [];
  String recommendationsMessage = '';

  bool isAddedWatchlist = false;
  String watchlistMessage = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<TVDetailBloc>().add(OnGetTVSeriesDetailEvent(widget.id));

        context.read<TVWatchlistBloc>().add(
          OnGetTVWatchlistStatusEvent(widget.id),
        );

        context.read<TVRecommendationsBloc>().add(
          OnGetTVSeriesRecommendationsEvent(widget.id),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TVDetailBloc, TVDetailState>(
          listener: (context, state) {
            if (state is GetTVSeriesDetailHasDataState) {
              tvDetail = state.result;
              isLoadingTVDetail = false;
            } else if (state is GetTVSeriesDetailErrorState) {
              tvDetailMessage = state.message.isEmpty
                  ? "Server error"
                  : state.message;
              isLoadingTVDetail = false;
            }
          },
        ),
        BlocListener<TVWatchlistBloc, TVWatchlistState>(
          listener: (context, state) {
            if (state is GetTVWatchlistStatusResultState) {
              isAddedWatchlist = state.result;
            } else if (state is SaveTVWatchlistSuccessState) {
              isAddedWatchlist = true;
              watchlistMessage = state.saveSuccessMessage;

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(watchlistMessage)));
            } else if (state is SaveTVWatchlistErrorState) {
              watchlistMessage = state.saveErrorMessage.isEmpty
                  ? "Server error"
                  : state.saveErrorMessage;

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(content: Text(watchlistMessage));
                },
              );
            } else if (state is RemoveTVWatchlistSuccessState) {
              isAddedWatchlist = false;
              watchlistMessage = state.removeSuccessMessage;

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(watchlistMessage)));
            } else if (state is RemoveTVWatchlistErrorState) {
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
        BlocListener<TVRecommendationsBloc, TVRecommendationsState>(
          listener: (context, state) {
            if (state is GetTVSeriesRecommendationsLoadingState) {
              isLoadingRecommendations = true;
              recommendations = [];
            } else if (state is GetTVSeriesRecommendationsHasDataState) {
              isLoadingRecommendations = false;
              recommendations = state.result;
            } else if (state is GetTVSeriesRecommendationsErrorState) {
              isLoadingRecommendations = false;
              recommendations = [];
              recommendationsMessage = state.message.isEmpty
                  ? "Server error"
                  : state.message;
            } else if (state is GetTVSeriesRecommendationsEmptyState) {
              isLoadingRecommendations = false;
              recommendations = [];
              recommendationsMessage =
                  "There isn't any tv series recommendations";
            }
          },
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<TVDetailBloc, TVDetailState>(
          builder: (context, state) {
            if (isLoadingTVDetail) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is GetTVSeriesDetailErrorState) {
              return EmptyResultWidget(tvDetailMessage);
            }

            return SafeArea(child: tvSeriesDetailContent());
          },
        ),
      ),
    );
  }

  Widget tvSeriesDetailContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${tvDetail?.posterPath}',
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
                            Text(tvDetail?.title ?? "", style: heading5),
                            watchlistButton(),
                            Text(
                              tvDetail?.genres == null
                                  ? ""
                                  : _showGenres(tvDetail!.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: (tvDetail?.voteAverage ?? 0) / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      Icon(Icons.star, color: mikadoYellow),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail?.voteAverage ?? 0}'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text('Overview', style: heading6),
                            Text(tvDetail?.overview ?? ""),
                            SizedBox(height: 16),
                            ...seasons(),
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
    return BlocBuilder<TVWatchlistBloc, TVWatchlistState>(
      builder: (context, state) {
        return FilledButton(
          onPressed: () async {
            // throw StateError("Test Crash");

            if (tvDetail != null) {
              if (isAddedWatchlist) {
                context.read<TVWatchlistBloc>().add(
                  OnRemoveTVWatchlistEvent(tvDetail!),
                );
              } else {
                context.read<TVWatchlistBloc>().add(
                  OnSaveTVWatchlistEvent(tvDetail!),
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

  List<Widget> seasons() {
    return [
      Text('Seasons', style: heading6),
      SizedBox(height: 8),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: tvDetail?.seasons.length,
        itemBuilder: (context, index) {
          return tvDetail == null
              ? SizedBox()
              : SeasonCard(tvDetail!.seasons[index]);
        },
      ),
      SizedBox(height: 16),
    ];
  }

  Widget recommendationsWidget() {
    return BlocBuilder<TVRecommendationsBloc, TVRecommendationsState>(
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

        return SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final tvRecommendation = recommendations[index];
              return RecommendationCard(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    TVDetailPage.routeName,
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
}
