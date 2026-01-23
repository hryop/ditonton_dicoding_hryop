import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_tv_watchlist_status.dart';
import 'package:tv_series/domain/usecase/remove_tv_watchlist.dart';
import 'package:tv_series/domain/usecase/save_tv_watchlist.dart';
import 'package:tv_series/presentation/bloc/tv_watchlist/watchlist_bloc.dart';

import 'tv_watchlist_bloc.mocks.dart';

@GenerateMocks([GetTvWatchlistStatus, SaveTvWatchlist, RemoveTvWatchlist])
void main() {
  late TVWatchlistBloc tvWatchlistBloc;
  late MockGetTvWatchlistStatus mockGetTvWatchlistStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;

  setUp(() {
    mockGetTvWatchlistStatus = MockGetTvWatchlistStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    tvWatchlistBloc = TVWatchlistBloc(
      removeTvWatchlist: mockRemoveTvWatchlist,
      saveTvWatchlist: mockSaveTvWatchlist,
      getTvWatchListStatus: mockGetTvWatchlistStatus,
    );
  });

  final tId = 1;
  final isAddedWatchlist = false;

  blocTest<TVWatchlistBloc, TVWatchlistState>(
    "should change movies data when data is gotten successfully",
    build: () {
      when(
        mockGetTvWatchlistStatus.execute(tId),
      ).thenAnswer((_) async => isAddedWatchlist);

      return tvWatchlistBloc;
    },
    act: (bloc) {
      bloc.add(OnGetTvWatchlistStatusEvent(tId));
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <TVWatchlistState>[
      GetTvWatchlistStatusLoadingState (),
      GetTvWatchlistStatusResultState (isAddedWatchlist),
    ],
    verify: (bloc) {
      verify(mockGetTvWatchlistStatus.execute(tId));
    },
  );

}
