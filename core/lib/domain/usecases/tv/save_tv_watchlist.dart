import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv/tv_series_detail.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';

class SaveTvWatchlist {
  final TvSeriesRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeriesDetail) {
    return repository.saveWatchlist(tvSeriesDetail);
  }
}
