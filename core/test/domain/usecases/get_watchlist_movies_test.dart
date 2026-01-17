import 'package:dartz/dartz.dart';
import '../../../../watchlist/lib/domain/usecase/get_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlist(mockWatchlistRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockWatchlistRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right(testMovieTableList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testMovieTableList));
  });
}
