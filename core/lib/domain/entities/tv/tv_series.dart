import 'package:core/domain/entities/movie/movie.dart';
import 'package:equatable/equatable.dart';

class TVSeries extends Equatable {
  TVSeries({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  TVSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genreIds,
    id,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    voteAverage,
    voteCount,
  ];

  Movie toMovieEntity() => Movie.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    title: title,
  );
}
