import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv_series.dart';
import 'package:ditonton/domain/entities/tv/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getAiringTodayTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();

  Future<Either<Failure, TvSeriesDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);

  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tvSeriesDetail);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail tvSeriesDetail);
}