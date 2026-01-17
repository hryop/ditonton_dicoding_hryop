import 'package:core/data/datasources/watchlist_local_data_source.dart';
import 'package:core/domain/entities/watchlist.dart';
import 'package:core/domain/repositories/watchlist_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource watchlistLocalDataSource;

  WatchlistRepositoryImpl({required this.watchlistLocalDataSource});

  @override
  Future<Either<Failure, List<Watchlist>>> getWatchlistMovies() async {
    final result = await watchlistLocalDataSource.getWatchlistMovies();
    return Right(result.map((model) => model.toMovieTableEntity()).toList());
  }
}
