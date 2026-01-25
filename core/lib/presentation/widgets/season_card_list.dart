import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/domain/entities/tv/tv_series_season.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeasonCard extends StatelessWidget {
  final TvSeriesSeason season;

  const SeasonCard(this.season, {super.key});

  String getAirDate() {
    String result = "First airing (No Info)";

    if (season.airDate.isEmpty) return result;

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime dateTime = dateFormat.parse(season.airDate);

    DateFormat dateFormatResult = DateFormat("dd MMMM yyyy");

    return "First airing ${dateFormatResult.format(dateTime)}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Card(
            child: Container(
              margin: const EdgeInsets.only(
                left: 80 + 16,
                bottom: 8,
                right: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    season.seasonName.isEmpty? '-' : season.seasonName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: heading6,
                  ),
                  Text(
                    getAirDate(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "${season.episodeCount} Episode${season.episodeCount > 1 ? "s" : ""}",
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 16,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: CachedNetworkImage(
                imageUrl: '$BASE_IMAGE_URL${season.posterPath}',
                width: 80,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
