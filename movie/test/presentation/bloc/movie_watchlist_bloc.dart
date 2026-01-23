import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecase/get_watchlist_status.dart';
import 'package:movie/domain/usecase/remove_watchlist.dart';
import 'package:movie/domain/usecase/save_movie_watchlist.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';

import 'movie_watchlist_bloc.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveMovieWatchlist, RemoveWatchlist])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveMovieWatchlist mockSaveMovieWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveMovieWatchlist = MockSaveMovieWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
      getWatchListStatus: mockGetWatchListStatus,
      saveMovieWatchlist: mockSaveMovieWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  final tId = 1;
  final isAddedWatchlist = false;

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    "should change movies data when data is gotten successfully",
    build: () {
      when(
        mockGetWatchListStatus.execute(tId),
      ).thenAnswer((_) async => isAddedWatchlist);

      return movieWatchlistBloc;
    },
    act: (bloc) {
      bloc.add(OnGetTvWatchlistStatusEvent(tId));
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <MovieWatchlistState>[
      GetMovieWatchlistStatusLoadingState(),
      GetMovieWatchlistStatusResultState(isAddedWatchlist),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );
}
