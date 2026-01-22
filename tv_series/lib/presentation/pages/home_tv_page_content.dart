import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/presentation/widgets/sub_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/widgets/empty_result_widget.dart';

class HomeTvPageContent extends StatefulWidget {
  const HomeTvPageContent({Key? key}) : super(key: key);

  @override
  _HomeTvPageContentState createState() => _HomeTvPageContentState();
}

class _HomeTvPageContentState extends State<HomeTvPageContent> {
  List<TVSeries> airingToday = [];
  String airingTodayMessage = "";
  List<TVSeries> popular = [];
  String popularMessage = "";
  List<TVSeries> topRated = [];
  String topRatedMessage = "";

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TVListBloc>()
        ..add(OnGetAiringTodayTVSeries())
        ..add(OnGetPopularAiringTVSeries())
        ..add(OnGetTopRatedTVSeries()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Airing Today', style: heading6),
            BlocConsumer<TVListBloc, TVListState>(
              listener: (context, state) {
                if (state is AiringTodayTVSeriesHasDataState) {
                  airingToday = state.result;
                } else if (state is AiringTodayTVSeriesErrorState) {
                  airingToday = [];
                  airingTodayMessage = state.message;
                } else if (state is AiringTodayTVSeriesEmptyState) {
                  airingToday = [];
                  airingTodayMessage = "There isn't any tv series airing today";
                }
              },
              builder: (context, state) {
                if (state is AiringTodayTVSeriesLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                if(airingToday.isEmpty){
                  return EmptyResultWidget(airingTodayMessage);
                }else{
                  return TvSeriesListWidget(airingToday);
                }

              },
            ),
            SubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
            ),
            BlocConsumer<TVListBloc, TVListState>(
              listener: (context, state) {
                if (state is PopularTVSeriesHasDataState) {
                  popular = state.result;
                } else if (state is PopularTVSeriesErrorState) {
                  popular = [];
                  popularMessage = state.message;
                } else if (state is PopularTVSeriesEmptyState) {
                  popular = [];
                  popularMessage = "There isn't any popular tv series";
                }
              },
              builder: (context, state) {
                if (state is PopularTVSeriesLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                if(popular.isEmpty){
                  return EmptyResultWidget(popularMessage);
                }else{
                  return TvSeriesListWidget(popular);
                }

              },
            ),
            SubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
            ),
            BlocConsumer<TVListBloc, TVListState>(
              listener: (context, state) {
                if (state is TopRatedTVSeriesHasDataState) {
                  topRated = state.result;
                } else if (state is TopRatedTVSeriesErrorState) {
                  topRated = [];
                  topRatedMessage = state.message;
                } else if (state is TopRatedTVSeriesEmptyState) {
                  topRated = [];
                  topRatedMessage = "There isn't any top rated tv series";
                }
              },
              builder: (context, state) {
                if (state is TopRatedTVSeriesLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                if(topRated.isEmpty){
                  return EmptyResultWidget(topRatedMessage);
                }else{
                  return TvSeriesListWidget(topRated);
                }

              },
            ),
          ],
        ),
      ),
    );
  }
}

class TvSeriesListWidget extends StatelessWidget {
  final List<TVSeries> tvSeries;

  TvSeriesListWidget(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
