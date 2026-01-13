import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:core/domain/usecases/tv/get_top_rated_tv_series.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvNotifier({required this.getTopRatedTvSeries});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<TVSeries> _tvSeries = [];

  List<TVSeries> get tvSeries => _tvSeries;

  String _message = '';

  String get message => _message;

  Future<void> fetchTopRatedTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _tvSeries = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
