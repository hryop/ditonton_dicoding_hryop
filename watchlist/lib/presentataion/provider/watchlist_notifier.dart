import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:watchlist/domain/usecase/get_watchlist.dart';

class WatchlistNotifier extends ChangeNotifier {
  var _watchlistMovies = <Watchlist>[];
  List<Watchlist> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistNotifier({required this.getWatchlistMovies});

  final GetWatchlist getWatchlistMovies;

  Future<void> fetchWatchlist() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
