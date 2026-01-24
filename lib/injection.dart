import 'package:core/data/datasources/tv/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv/tv_series_remote_data_source.dart';
import 'package:core/data/datasources/watchlist_local_data_source.dart';
import 'package:core/domain/repositories/watchlist_repository.dart';
import 'package:core/utils/network/ssl_pinning.dart';
import 'package:core/utils/network/network_info.dart';
import 'package:core/utils/network/network_info_impl.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie/movie_local_data_source.dart';
import 'package:core/data/datasources/movie/movie_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/data/repositories/watchlist_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:movie/domain/usecase/usecase.dart';
import 'package:movie/presentation/bloc/bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/domain/usecase/get_watchlist.dart';
import 'package:watchlist/presentataion/bloc/watchlist_bloc.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => SearchTvSeriesBloc(locator()));
  locator.registerFactory(() => WatchlistBloc(locator()));
  locator.registerFactory(() => TVRecommendationsBloc(locator()));
  locator.registerFactory(
    () => TVListBloc(
      getAiringTodayTVSeries: locator(),
      getPopularTVSeries: locator(),
      getTopRatedTVSeries: locator(),
    ),
  );
  locator.registerFactory(() => TVDetailBloc(getTVSeriesDetail: locator()));
  locator.registerFactory(
    () => TVWatchlistBloc(
      removeTVWatchlist: locator(),
      saveTVWatchlist: locator(),
      getTVWatchListStatus: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieListBloc(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(() => MovieDetailBloc(getMovieDetail: locator()));
  locator.registerFactory(
    () => MovieWatchlistBloc(
      getWatchListStatus: locator(),
      saveMovieWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationsBloc(getMovieRecommendations: locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));

  locator.registerLazySingleton(() => GetWatchlist(locator()));

  locator.registerLazySingleton(() => GetAiringTodayTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SaveTVWatchlist(locator()));
  locator.registerLazySingleton(() => GetTVWatchlistStatus(locator()));
  locator.registerLazySingleton(() => RemoveTVWatchlist(locator()));

  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
      watchlistLocalDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
      watchlistLocalDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(watchlistLocalDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<TVSereisRemoteDataSource>(
    () => TVSereisRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TVSereisLocalDataSource>(
    () => TVSereisLocalDataSourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<WatchlistLocalDataSource>(
    () => WatchlistLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => DataConnectionChecker());
  locator.registerLazySingleton(() => HttpSSLPinning.client);

  // network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));
}
