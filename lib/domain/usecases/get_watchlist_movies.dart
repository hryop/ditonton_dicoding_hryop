import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie_table.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:core/utils/failure.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<MovieTable>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
