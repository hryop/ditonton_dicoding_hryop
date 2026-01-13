import 'package:equatable/equatable.dart';

class TvSeriesSeason extends Equatable{
  final String airDate;
  final int episodeCount;
  final String seasonName;
  final String posterPath;

  TvSeriesSeason({
    required this.airDate,
    required this.episodeCount,
    required this.seasonName,
    required this.posterPath
  });

  @override
  List<Object?> get props => [
    airDate,
    episodeCount,
    seasonName,
    posterPath
  ];

}