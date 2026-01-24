import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';

class GetTVSeriesDetail {
  final TvSeriesRepository repository;

  GetTVSeriesDetail(this.repository);

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
