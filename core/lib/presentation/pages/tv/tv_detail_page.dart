import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:core/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:core/presentation/widgets/season_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_detail';

  final int id;

  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TvDetailNotifier>(
        context,
        listen: false,
      ).fetchTvSeriesDetail(widget.id);
      Provider.of<TvDetailNotifier>(
        context,
        listen: false,
      ).loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvDetailState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.tvDetailState == RequestState.Loaded) {
            return SafeArea(
              child: DetailContent(
                provider.tvDetail,
                provider.tvDetailRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvDetail;
  final List<TVSeries> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.tvDetail, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${tvDetail.posterPath}',
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
                            Text(tvDetail.title, style: heading5),
                            watchlistButton(context),
                            Text(_showGenres(tvDetail.genres)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvDetail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      Icon(Icons.star, color: mikadoYellow),
                                  itemSize: 24,
                                ),
                                Text('${tvDetail.voteAverage}'),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text('Overview', style: heading6),
                            Text(tvDetail.overview),
                            SizedBox(height: 16),
                            ...seasons(),
                            ...recomendations(),
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

  Widget watchlistButton(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        if (!isAddedWatchlist) {
          await Provider.of<TvDetailNotifier>(
            context,
            listen: false,
          ).addWatchlist(tvDetail);
        } else {
          await Provider.of<TvDetailNotifier>(
            context,
            listen: false,
          ).removeFromWatchlist(tvDetail);
        }

        final message = Provider.of<TvDetailNotifier>(
          context,
          listen: false,
        ).watchlistMessage;

        if (message == TvDetailNotifier.watchlistAddSuccessMessage ||
            message == TvDetailNotifier.watchlistRemoveSuccessMessage) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(content: Text(message));
            },
          );
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
  }

  List<Widget> seasons() {
    return [
      Text('Seasons', style: heading6),
      SizedBox(height: 8),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: tvDetail.seasons.length,
        itemBuilder: (context, index) {
          return SeasonCard(tvDetail.seasons[index]);
        },
      ),
      SizedBox(height: 16),
    ];
  }

  List<Widget> recomendations() {
    return [
      Text('Recommendations', style: heading6),
      Consumer<TvDetailNotifier>(
        builder: (context, data, child) {
          if (data.recommendationState == RequestState.Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (data.recommendationState == RequestState.Error) {
            return Text(data.message);
          } else if (data.recommendationState == RequestState.Loaded) {
            return Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final tvRecommendation = recommendations[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          TvDetailPage.ROUTE_NAME,
                          arguments: tvRecommendation.id,
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: CachedNetworkImage(
                          imageUrl:
                              '$BASE_IMAGE_URL${tvRecommendation.posterPath}',
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: recommendations.length,
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      SizedBox(height: 16),
    ];
  }

  String _showGenres(List<Genre> genres) {
    if(genres.isEmpty) return '';
    return genres.map((e) => e.name).toList().join(',');
  }
}
