import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/presentation/pages/movie/movie_detail_page.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool showContentType;
  final String contentType;

  MovieCard(this.movie,
      {this.showContentType = false,
      this.contentType = DatabaseHelper.CONTENT_TYPE_MOVIE});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            contentType == DatabaseHelper.CONTENT_TYPE_MOVIE
                ? MovieDetailPage.ROUTE_NAME
                : DETAIL_TV_SERIES_ROUTE,
            arguments: movie.id,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: heading6,
                    ),
                    showContentType
                        ? Text(
                            contentType.split(' ').map((word) {
                              if (word.isEmpty) return '';
                              return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
                            }).join(' '),
                            overflow: TextOverflow.ellipsis,
                          )
                        : SizedBox(),
                    SizedBox(height: 16),
                    Text(
                      movie.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  width: 80,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
