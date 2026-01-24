import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/tv/tv_series_model.dart';
import 'package:core/domain/entities/movie/movie.dart';
import 'package:core/domain/entities/movie/movie_detail.dart';
import 'package:core/domain/entities/watchlist.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

import 'movie/movie_model.dart';

class WatchlistModel extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? contentType;

  WatchlistModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.contentType,
  });

  factory WatchlistModel.fromEntity(MovieDetail movie) =>
      WatchlistModel(
          id: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
          overview: movie.overview,
          contentType: DatabaseHelper.CONTENT_TYPE_MOVIE);

  factory WatchlistModel.fromTvEntity(TVSeriesDetail tvSeriesDetail) =>
      WatchlistModel(
          id: tvSeriesDetail.id,
          title: tvSeriesDetail.title,
          posterPath: tvSeriesDetail.posterPath,
          overview: tvSeriesDetail.overview,
          contentType: DatabaseHelper.CONTENT_TYPE_TV);

  factory WatchlistModel.fromMap(Map<String, dynamic> map) =>
      WatchlistModel(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        contentType: map['contentType'],
      );

  factory WatchlistModel.fromDTO(MovieModel movie) =>
      WatchlistModel(
          id: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
          overview: movie.overview,
          contentType: DatabaseHelper.CONTENT_TYPE_MOVIE);

  factory WatchlistModel.fromTvDTO(TvSeriesModel tvSeriesModel) =>
      WatchlistModel(
          id: tvSeriesModel.id,
          title: tvSeriesModel.title,
          posterPath: tvSeriesModel.posterPath,
          overview: tvSeriesModel.overview,
          contentType: DatabaseHelper.CONTENT_TYPE_TV);

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'contentType': contentType,
      };

  Movie toEntity() =>
      Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  TVSeries toTvEntity() =>
      TVSeries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  Watchlist toMovieTableEntity() =>
      Watchlist
        (id: id,
          title: title,
          posterPath: posterPath,
          overview: overview,
          contentType: contentType);

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
