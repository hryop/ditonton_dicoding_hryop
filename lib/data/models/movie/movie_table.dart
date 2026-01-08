import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv/tv_series_model.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

import 'movie_model.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? contentType;

  MovieTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.contentType,
  });

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
      contentType: DatabaseHelper.CONTENT_TYPE_MOVIE);

  factory MovieTable.fromTvEntity(TvSeriesDetail tvSeriesDetail) => MovieTable(
      id: tvSeriesDetail.id,
      title: tvSeriesDetail.title,
      posterPath: tvSeriesDetail.posterPath,
      overview: tvSeriesDetail.overview,
      contentType: DatabaseHelper.CONTENT_TYPE_TV);

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        contentType: map['contentType'],
      );

  factory MovieTable.fromDTO(MovieModel movie) => MovieTable(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
      contentType: DatabaseHelper.CONTENT_TYPE_MOVIE);

  factory MovieTable.fromTvDTO(TvSeriesModel tvSeriesModel) => MovieTable(
      id: tvSeriesModel.id,
      title: tvSeriesModel.title,
      posterPath: tvSeriesModel.posterPath,
      overview: tvSeriesModel.overview,
      contentType: DatabaseHelper.CONTENT_TYPE_TV);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'contentType': contentType,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  TvSeries toTvEntity() => TvSeries.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, posterPath, overview];
}
