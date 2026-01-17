import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';

class GetAiringTodayTvSeries {
  final TvSeriesRepository repository;

  GetAiringTodayTvSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getAiringTodayTvSeries();
  }
}
