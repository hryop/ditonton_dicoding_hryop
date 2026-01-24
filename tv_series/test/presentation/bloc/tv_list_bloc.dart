import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_airing_today_tv_series.dart';
import 'package:tv_series/domain/usecase/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_list_bloc.dart';

import 'tv_list_bloc.mocks.dart';

@GenerateMocks([
  GetAiringTodayTVSeries,
  GetPopularTVSeries,
  GetTopRatedTVSeries,
])
void main() {
  late TVListBloc tvListBloc;
  late MockGetAiringTodayTVSeries mockGetAiringTodayTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetAiringTodayTVSeries = MockGetAiringTodayTVSeries();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    tvListBloc = TVListBloc(
      getAiringTodayTVSeries: mockGetAiringTodayTVSeries,
      getPopularTVSeries: mockGetPopularTVSeries,
      getTopRatedTVSeries: mockGetTopRatedTVSeries,
    );
  });

  final tTVSeries = TVSeries(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTVSeriesList = <TVSeries>[tTVSeries];

  blocTest<TVListBloc, TVListState>(
    "should change movies data when data is gotten successfully",
    build: () {
      when(
        mockGetAiringTodayTVSeries.execute(),
      ).thenAnswer((_) async => Right(tTVSeriesList));

      when(
        mockGetPopularTVSeries.execute(),
      ).thenAnswer((_) async => Right(tTVSeriesList));

      when(
        mockGetTopRatedTVSeries.execute(),
      ).thenAnswer((_) async => Right(tTVSeriesList));

      return tvListBloc;
    },
    act: (bloc) {
      bloc.add(OnGetAiringTodayTVSeries());
      bloc.add(OnGetPopularAiringTVSeries());
      bloc.add(OnGetTopRatedTVSeries());
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <TVListState>[
      AiringTodayTVSeriesLoadingState(),
      AiringTodayTVSeriesHasDataState(tTVSeriesList),
      PopularTVSeriesLoadingState(),
      PopularTVSeriesHasDataState(tTVSeriesList),
      TopRatedTVSeriesLoadingState(),
      TopRatedTVSeriesHasDataState(tTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTVSeries.execute());
      verify(mockGetPopularTVSeries.execute());
      verify(mockGetTopRatedTVSeries.execute());
    },
  );
}
