import 'package:core/data/datasources/tv/tv_series_local_data_source.dart';
import 'package:core/data/datasources/tv/tv_series_remote_data_source.dart';
import 'package:core/data/datasources/watchlist_local_data_source.dart';
import 'package:core/domain/repositories/watchlist_repository.dart';
import 'package:core/utils/network_info.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movie/movie_local_data_source.dart';
import 'package:core/data/datasources/movie/movie_remote_data_source.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  NetworkInfo,
  TVSereisRemoteDataSource,
  TVSereisLocalDataSource,
  WatchlistLocalDataSource,
  TvSeriesRepository,
  WatchlistRepository
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
