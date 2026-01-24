import 'package:core/domain/repositories/tv_series_repository.dart';

class GetTVWatchlistStatus{
  final TvSeriesRepository repository;

  GetTVWatchlistStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
