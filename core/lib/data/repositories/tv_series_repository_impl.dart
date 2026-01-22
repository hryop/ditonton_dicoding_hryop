import 'dart:io';

import 'package:core/data/datasources/tv/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv/tv_series_remote_data_source.dart';
import 'package:core/data/datasources/watchlist_local_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/network/network_info.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/watchlist_model.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TVSereisRemoteDataSource remoteDataSource;
  final TVSereisLocalDataSource localDataSource;
  final WatchlistLocalDataSource watchlistLocalDataSource;
  final NetworkInfo networkInfo;

  TvSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.watchlistLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TVSeries>>> getAiringTodayTvSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getAiringTodayTvSeries();

        localDataSource.cacheAiringTodayTvSeries(result
            .map((tvSeries) => WatchlistModel.fromTvDTO(tvSeries))
            .toList());

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      } on SocketException {
        return Left(ConnectionFailure('Failed to connect to the network'));
      }
    } else {
      try {
        final result = await localDataSource.getCachedAiringTodayTvSeries();
        return Right(result.map((model) => model.toTvEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteDataSource.getPopularTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTvSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTvSeriesRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTvSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(
      TvSeriesDetail tvSeriesDetail) async {
    try {
      final result = await watchlistLocalDataSource
          .insertWatchlist(WatchlistModel.fromTvEntity(tvSeriesDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result =
        await watchlistLocalDataSource.getWatchlistItemById(id, DatabaseHelper.CONTENT_TYPE_TV);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      TvSeriesDetail tvSeriesDetail) async {
    try {
      final result = await watchlistLocalDataSource
          .removeWatchlist(WatchlistModel.fromTvEntity(tvSeriesDetail));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> searchTvSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
