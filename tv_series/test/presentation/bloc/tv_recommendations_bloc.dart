import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_tv_series_recommendations.dart';
import 'package:tv_series/presentation/bloc/tv_recommendations/tv_recommendations_bloc.dart';

import 'tv_recommendations_bloc.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TVRecommendationsBloc tvRecommendationsBloc;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvRecommendationsBloc = TVRecommendationsBloc(
      mockGetTvSeriesRecommendations,
    );
  });

  final tId = 1;
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

  blocTest<TVRecommendationsBloc, TVRecommendationsState>(
    "should change movies data when data is gotten successfully",
    build: () {
      when(
        mockGetTvSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tTvSeriesList));

      return tvRecommendationsBloc;
    },
    act: (bloc) {
      bloc.add(OnGetTvSeriesRecommendationsEvent(tId));
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <TVRecommendationsState>[
      GetTvSeriesRecommendationsLoadingState(),
      GetTvSeriesRecommendationsHasDataState(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(tId));
    },
  );
}
