import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/watchlist_model.dart';

abstract class WatchlistLocalDataSource {
  Future<WatchlistModel?> getWatchlistItemById(int id, String contentType);

  Future<String> insertWatchlist(WatchlistModel movie);

  Future<String> removeWatchlist(WatchlistModel movie);

  Future<List<WatchlistModel>> getWatchlistMovies();

}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchlistLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<WatchlistModel?> getWatchlistItemById(int id, String contentType) async {
    final result = await databaseHelper.getWatchlistItemById(id, contentType);
    if (result != null) {
      return WatchlistModel.fromMap(result);
    } else {
      return null;
    }
  }


  @override
  Future<String> insertWatchlist(WatchlistModel movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistModel movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<WatchlistModel>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => WatchlistModel.fromMap(data)).toList();
  }

}
