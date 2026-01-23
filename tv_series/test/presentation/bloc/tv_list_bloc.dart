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
  GetAiringTodayTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
])
void main() {
  late TVListBloc tvListBloc;
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    tvListBloc = TVListBloc(
      getAiringTodayTvSeries: mockGetAiringTodayTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    );
  });

  final tTvSeries = TVSeries(
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
  final tTvSeriesList = <TVSeries>[tTvSeries];

  blocTest<TVListBloc, TVListState>(
    "should change movies data when data is gotten successfully",
    build: () {
      when(
        mockGetAiringTodayTvSeries.execute(),
      ).thenAnswer((_) async => Right(tTvSeriesList));

      when(
        mockGetPopularTvSeries.execute(),
      ).thenAnswer((_) async => Right(tTvSeriesList));

      when(
        mockGetTopRatedTvSeries.execute(),
      ).thenAnswer((_) async => Right(tTvSeriesList));

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
      AiringTodayTVSeriesHasDataState(tTvSeriesList),
      PopularTVSeriesLoadingState(),
      PopularTVSeriesHasDataState(tTvSeriesList),
      TopRatedTVSeriesLoadingState(),
      TopRatedTVSeriesHasDataState(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeries.execute());
      verify(mockGetPopularTvSeries.execute());
      verify(mockGetTopRatedTvSeries.execute());
    },
  );
}
