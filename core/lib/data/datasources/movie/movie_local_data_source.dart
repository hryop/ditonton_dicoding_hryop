import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/watchlist_model.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheNowPlayingMovies(List<WatchlistModel> movies);

  Future<List<WatchlistModel>> getCachedNowPlayingMovies();

  Future<List<WatchlistModel>> getCachedAiringTodayTvSeries();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheNowPlayingMovies(List<WatchlistModel> movies) async {
    await databaseHelper.clearCache(DatabaseHelper.CATEGORY_NOW_PLAYING);
    await databaseHelper.insertCacheTransaction(movies, DatabaseHelper.CATEGORY_NOW_PLAYING);
  }

  @override
  Future<List<WatchlistModel>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper.getCacheMovies(DatabaseHelper.CATEGORY_NOW_PLAYING);
    if (result.length > 0) {
      return result.map((data) => WatchlistModel.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<List<WatchlistModel>> getCachedAiringTodayTvSeries() async {
    final result = await databaseHelper.getCacheMovies(DatabaseHelper.CATEGORY_AIRING_TODAY);
    if (result.length > 0) {
      return result.map((data) => WatchlistModel.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
