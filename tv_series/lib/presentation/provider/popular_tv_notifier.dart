import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:flutter/foundation.dart';
import 'package:tv_series/domain/usecase/get_popular_tv_series.dart';

class PopularTvNotifier extends ChangeNotifier {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvNotifier(this.getPopularTvSeries);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TVSeries> _tvSeries = [];

  List<TVSeries> get tvSeries => _tvSeries;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (TvSeriessData) {
        _tvSeries = TvSeriessData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
