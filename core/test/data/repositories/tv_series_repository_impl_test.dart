import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/watchlist_model.dart';
import 'package:core/data/models/tv/tv_series_detail_model.dart';
import 'package:core/data/models/tv/tv_series_model.dart';
import 'package:core/data/models/tv/tv_series_season_model.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTVSereisRemoteDataSource mockRemoteDataSource;
  late MockTVSereisLocalDataSource mockLocalDataSource;
  late MockWatchlistLocalDataSource mockWatchlistLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  // late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockRemoteDataSource = MockTVSereisRemoteDataSource();
    mockLocalDataSource = MockTVSereisLocalDataSource();
    mockWatchlistLocalDataSource = MockWatchlistLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    // mockDatabaseHelper = MockDatabaseHelper();
    repository = TvSeriesRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
        watchlistLocalDataSource: mockWatchlistLocalDataSource);
  });

  final tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tTvSeries = TVSeries(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testMovieCache = WatchlistModel(
      id: 557,
      overview:
          'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      title: 'Spider-Man',
      contentType: DatabaseHelper.contentTypeTV);

  // final testMovieCacheMap = {
  //   'id': 557,
  //   'overview':
  //       'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  //   'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  //   'title': 'Spider-Man',
  // };

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TVSeries>[tTvSeries];
  final testTvSeriesFromCache = testMovieCache.toTvEntity();

  group('Now Playing Movies', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should check if the device is online', () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenAnswer((_) async => []);

      // act
      await repository.getAiringTodayTvSeries();

      // assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringTodayTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);
        // act
        final result = await repository.getAiringTodayTvSeries();
        // assert
        verify(mockRemoteDataSource.getAiringTodayTvSeries());
        /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      });

      test(
          'should cache data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringTodayTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);

        // act
        await repository.getAiringTodayTvSeries();

        // assert
        verify(mockRemoteDataSource.getAiringTodayTvSeries());
        verify(mockLocalDataSource.cacheAiringTodayTvSeries([testMovieCache]));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(mockRemoteDataSource.getAiringTodayTvSeries())
            .thenThrow(ServerException());
        // act
        final result = await repository.getAiringTodayTvSeries();
        // assert
        verify(mockRemoteDataSource.getAiringTodayTvSeries());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        //arrange
        when(mockLocalDataSource.getCachedAiringTodayTvSeries())
            .thenAnswer((_) async => [testMovieCache]);
        //act
        final result = await repository.getAiringTodayTvSeries();
        //assert
        verify(mockLocalDataSource.getCachedAiringTodayTvSeries());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvSeriesFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        // arrange
        when(mockLocalDataSource.getCachedAiringTodayTvSeries())
            .thenThrow(CacheException('No Cache'));
        // act
        final result = await repository.getAiringTodayTvSeries();
        // assert
        verify(mockLocalDataSource.getCachedAiringTodayTvSeries());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getAiringTodayTvSeries();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTvSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  // group('cache now playing movies', () {
  //   test('should call database helper to save data', () async {
  //     // arrange
  //     when(mockDatabaseHelper.clearCache('now playing'))
  //         .thenAnswer((_) async => 1);
  //
  //     // act
  //     await mockLocalDataSource.cacheNowPlayingMovies([testMovieCache]);
  //
  //     // assert
  //     verify(mockDatabaseHelper.clearCache('now playing'));
  //     verify(mockDatabaseHelper
  //         .insertCacheTransaction([testMovieCache], 'now playing'));
  //   });
  //
  //   test('should return list of movies from db when data exist', () async {
  //     // arrange
  //     when(mockDatabaseHelper.getCacheMovies('now playing'))
  //         .thenAnswer((_) async => [testMovieCacheMap]);
  //
  //     // act
  //     final result = await mockLocalDataSource.getCachedAiringTodayTvSeries();
  //
  //     // assert
  //     expect(result, [testMovieCache]);
  //   });
  //
  //   test('should throw CacheException when cache data is not exist', () async {
  //     // arrange
  //     when(mockDatabaseHelper.getCacheMovies('now playing'))
  //         .thenAnswer((_) async => []);
  //     // act
  //     final call = mockLocalDataSource.getCachedAiringTodayTvSeries();
  //     // assert
  //     expect(() => call, throwsA(isA<CacheException>()));
  //   });
  // });

  group('Popular Movies', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Movie Detail', () {
    final tId = 1;
    final tTvSeriesDetailResponse = TvSeriesDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      voteAverage: 1,
      voteCount: 1,
      seasons: [
        TvSeriesSeasonModel(
            airDate: '2012-08-26',
            episodeCount: 6,
            seasonName: 'Specials',
            posterPath: "posterPath")
      ],
    );

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenAnswer((_) async => tTvSeriesDetailResponse);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Movie Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenAnswer((_) async => tTvSeriesList);
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Movies', () {
    final tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockWatchlistLocalDataSource.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockWatchlistLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockWatchlistLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockWatchlistLocalDataSource.removeWatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockWatchlistLocalDataSource.getWatchlistItemById(
              tId, DatabaseHelper.contentTypeTV))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });
}
