import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/watchlist_model.dart';

abstract class TVSereisLocalDataSource {
  Future<void> cacheAiringTodayTvSeries(List<WatchlistModel> movies);

  Future<List<WatchlistModel>> getCachedAiringTodayTvSeries();
}

class TVSereisLocalDataSourceImpl implements TVSereisLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVSereisLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheAiringTodayTvSeries(List<WatchlistModel> movies) async {
    await databaseHelper.clearCache(DatabaseHelper.categoryAairingToday);
    await databaseHelper.insertCacheTransaction(movies, DatabaseHelper.categoryAairingToday);
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
