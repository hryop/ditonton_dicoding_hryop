import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getAiringTodayTvSeries();

  Future<Either<Failure, List<TVSeries>>> getPopularTvSeries();

  Future<Either<Failure, List<TVSeries>>> getTopRatedTvSeries();

  Future<Either<Failure, TVSeriesDetail>> getTvDetail(int id);

  Future<Either<Failure, List<TVSeries>>> getTvSeriesRecommendations(int id);

  Future<Either<Failure, String>> saveWatchlist(TVSeriesDetail tvSeriesDetail);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, String>> removeWatchlist(
      TVSeriesDetail tvSeriesDetail);

  Future<Either<Failure, List<TVSeries>>> searchTvSeries(String query);
}
