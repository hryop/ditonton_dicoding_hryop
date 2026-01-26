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
    await databaseHelper.clearCache(DatabaseHelper.categoryNowPlaying);
    await databaseHelper.insertCacheTransaction(movies, DatabaseHelper.categoryNowPlaying);
  }

  @override
  Future<List<WatchlistModel>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper.getCacheMovies(DatabaseHelper.categoryNowPlaying);
    if (result.isNotEmpty) {
      return result.map((data) => WatchlistModel.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<List<WatchlistModel>> getCachedAiringTodayTvSeries() async {
    final result = await databaseHelper.getCacheMovies(DatabaseHelper.categoryAairingToday);
    if (result.isNotEmpty) {
      return result.map((data) => WatchlistModel.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
