import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_tv_watchlist_status.dart';
import 'package:tv_series/domain/usecase/remove_tv_watchlist.dart';
import 'package:tv_series/domain/usecase/save_tv_watchlist.dart';
import 'package:tv_series/presentation/bloc/tv_watchlist/watchlist_bloc.dart';

import 'tv_watchlist_bloc.mocks.dart';

@GenerateMocks([GetTVWatchlistStatus, SaveTVWatchlist, RemoveTVWatchlist])
void main() {
  late TVWatchlistBloc tvWatchlistBloc;
  late MockGetTVWatchlistStatus mockGetTVWatchlistStatus;
  late MockSaveTVWatchlist mockSaveTVWatchlist;
  late MockRemoveTVWatchlist mockRemoveTVWatchlist;

  setUp(() {
    mockGetTVWatchlistStatus = MockGetTVWatchlistStatus();
    mockSaveTVWatchlist = MockSaveTVWatchlist();
    mockRemoveTVWatchlist = MockRemoveTVWatchlist();
    tvWatchlistBloc = TVWatchlistBloc(
      removeTVWatchlist: mockRemoveTVWatchlist,
      saveTVWatchlist: mockSaveTVWatchlist,
      getTVWatchListStatus: mockGetTVWatchlistStatus,
    );
  });

  final tId = 1;
  final isAddedWatchlist = false;

  blocTest<TVWatchlistBloc, TVWatchlistState>(
    "should change movies data when data is gotten successfully",
    build: () {
      when(
        mockGetTVWatchlistStatus.execute(tId),
      ).thenAnswer((_) async => isAddedWatchlist);

      return tvWatchlistBloc;
    },
    act: (bloc) {
      bloc.add(OnGetTVWatchlistStatusEvent(tId));
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <TVWatchlistState>[
      GetTVWatchlistStatusLoadingState (),
      GetTVWatchlistStatusResultState (isAddedWatchlist),
    ],
    verify: (bloc) {
      verify(mockGetTVWatchlistStatus.execute(tId));
    },
  );

}
