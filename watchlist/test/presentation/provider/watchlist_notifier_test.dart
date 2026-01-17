import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import '../../../lib/domain/usecase/get_watchlist.dart';
import '../../../lib/presentataion/provider/watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_notifier_test.mocks.dart';


@GenerateMocks([GetWatchlist])
void main() {
  late WatchlistNotifier provider;
  late MockGetWatchlist mockGetWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlist = MockGetWatchlist();
    provider = WatchlistNotifier(
      getWatchlistMovies: mockGetWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlist.execute())
        .thenAnswer((_) async => Right([testWatchlistMovieTable.toMovieTableEntity()]));
    // act
    await provider.fetchWatchlist();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistMovies, [testWatchlistMovieTable.toMovieTableEntity()]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlist.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlist();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
