import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/usecase/get_airing_today_tv_series.dart';
import 'package:tv_series/domain/usecase/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecase/get_top_rated_tv_series.dart';

class TvListNotifier extends ChangeNotifier {
  final GetAiringTodayTvSeries getAiringTodayTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TvListNotifier({
    required this.getAiringTodayTvSeries,
    required this.getPopularTvSeries,
    required this.getTopRatedTvSeries,
  });

  var _airingTodayTvSeries = <TVSeries>[];

  List<TVSeries> get airingTodayTvSeries => _airingTodayTvSeries;

  RequestState _airingTodayState = RequestState.Empty;

  RequestState get airingTodayState => _airingTodayState;

  var _popularTvSeries = <TVSeries>[];

  List<TVSeries> get popularTvSeries => _popularTvSeries;

  RequestState _popularTvSeriesState = RequestState.Empty;

  RequestState get popularTvSeriesState => _popularTvSeriesState;

  var _topRatedTvSeries = <TVSeries>[];

  List<TVSeries> get topRatedTvSeries => _topRatedTvSeries;

  RequestState _topRatedTvSeriesState = RequestState.Empty;

  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;

  String _message = '';

  String get message => _message;

  Future<void> fetchAiringTodayTvSeries() async {
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvSeries.execute();
    result.fold(
      (failure) {
        _airingTodayState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _airingTodayState = RequestState.Loaded;
        _airingTodayTvSeries = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        _popularTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularTvSeriesState = RequestState.Loaded;
        _popularTvSeries = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        _topRatedTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedTvSeriesState = RequestState.Loaded;
        _topRatedTvSeries = moviesData;
        notifyListeners();
      },
    );
  }
}
