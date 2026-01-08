import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/movie/movie_table.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<MovieTable>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
