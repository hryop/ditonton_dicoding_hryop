import 'package:equatable/equatable.dart';

import 'movie/movie.dart';

class Watchlist extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? contentType;

  const Watchlist({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.contentType,
  });

  Movie toMovieEntity() =>
      Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        posterPath,
        overview,
        contentType,
      ];
}
