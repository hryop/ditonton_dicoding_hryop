import 'package:core/domain/entities/tv/tv_series_season.dart';
import 'package:equatable/equatable.dart';

class TvSeriesSeasonModel extends Equatable {
  final String airDate;
  final int episodeCount;
  final String seasonName;
  final String posterPath;

  TvSeriesSeasonModel(
      {required this.airDate,
      required this.episodeCount,
      required this.seasonName,
      required this.posterPath});

  factory TvSeriesSeasonModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesSeasonModel(
          airDate: json["air_date"] ?? "",
          episodeCount: json["episode_count"] ?? 0,
          seasonName: json["name"] ?? "",
          posterPath: json["poster_path"] ?? "");

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_count": episodeCount,
        "name": seasonName,
        "poster_path": posterPath,
      };

  TvSeriesSeason toEntity() {
    return TvSeriesSeason(
        airDate: this.airDate,
        episodeCount: this.episodeCount,
        seasonName: this.seasonName,
        posterPath: this.posterPath);
  }

  @override
  List<Object?> get props => [airDate, episodeCount, seasonName];
}
