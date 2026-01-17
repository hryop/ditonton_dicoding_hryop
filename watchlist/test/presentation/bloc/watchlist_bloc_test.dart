import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecase/get_watchlist.dart';
import 'package:watchlist/presentataion/bloc/watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlist])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchlist mockGetWatchlist;

  setUp(() {
    mockGetWatchlist = MockGetWatchlist();
    watchlistBloc = WatchlistBloc(mockGetWatchlist);
  });

  blocTest<WatchlistBloc, WatchlistState>(
    'should change movies data when data is gotten successfully',
    build: () {
      when(mockGetWatchlist.execute()).thenAnswer(
        (_) async => Right([testWatchlistMovieTable.toMovieTableEntity()]),
      );
      
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchListEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () =>[
      WatchlistLoadingState(),
      WatchlistHasDataState([testWatchlistMovieTable.toMovieTableEntity()])
    ],
    verify: (bloc){
      verify(mockGetWatchlist.execute());
    }
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'should return error when data is unsuccessful',
    build: () {
      when(mockGetWatchlist.execute()).thenAnswer(
        (_) async => Left(DatabaseFailure("Can't get data")),
      );

      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnGetWatchListEvent()),
    wait: const Duration(milliseconds: 100),
    expect: () =>[
      WatchlistLoadingState(),
      WatchlistErrorState("Can't get data")
    ],
    verify: (bloc){
      verify(mockGetWatchlist.execute());
    }
  );
}
