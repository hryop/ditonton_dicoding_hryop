import 'package:core/data/repositories/watchlist_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistRepositoryImpl repository;
  late MockWatchlistLocalDataSource mockWatchlistLocalDataSource;

  setUp(() {
    mockWatchlistLocalDataSource = MockWatchlistLocalDataSource();
    repository = WatchlistRepositoryImpl(
      watchlistLocalDataSource: mockWatchlistLocalDataSource,
    );
  });
  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(
        mockWatchlistLocalDataSource.getWatchlistMovies(),
      ).thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testMovieTable.toMovieTableEntity()]);
    });
  });
}