import 'package:core/utils/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table_model.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTableModel movie);

  Future<String> removeWatchlist(MovieTableModel movie);

  Future<MovieTableModel?> getMovieById(int id, String contentType);

  Future<List<MovieTableModel>> getWatchlistMovies();

  Future<void> cacheNowPlayingMovies(List<MovieTableModel> movies);

  Future<List<MovieTableModel>> getCachedNowPlayingMovies();

  Future<List<MovieTableModel>> getCachedAiringTodayTvSeries();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTableModel movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTableModel movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTableModel?> getMovieById(int id, String contentType) async {
    final result = await databaseHelper.getMovieById(id, contentType);
    if (result != null) {
      return MovieTableModel.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTableModel>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTableModel.fromMap(data)).toList();
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTableModel> movies) async {
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertCacheTransaction(movies, 'now playing');
  }

  @override
  Future<List<MovieTableModel>> getCachedNowPlayingMovies() async {
    final result = await databaseHelper.getCacheMovies('now playing');
    if (result.length > 0) {
      return result.map((data) => MovieTableModel.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<List<MovieTableModel>> getCachedAiringTodayTvSeries() async {
    final result = await databaseHelper.getCacheMovies('airing today');
    if (result.length > 0) {
      return result.map((data) => MovieTableModel.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }
}
