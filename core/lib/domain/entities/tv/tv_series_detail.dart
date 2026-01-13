import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv/tv_series_season.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.seasons,
  });

  final bool adult;
  final String? backdropPath;

  final List<Genre> genres;
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;

  final String title;
  final double voteAverage;
  final int voteCount;

  final List<TvSeriesSeason> seasons;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        originalTitle,
        overview,
        posterPath,
        title,
        voteAverage,
        voteCount,
        seasons
      ];
}
