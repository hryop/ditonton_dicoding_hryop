import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_tv_series_recommendations.dart';
import 'package:tv_series/presentation/bloc/tv_recommendations/tv_recommendations_bloc.dart';

import 'tv_recommendations_bloc.mocks.dart';

@GenerateMocks([GetTVSeriesRecommendations])
void main() {
  late TVRecommendationsBloc tvRecommendationsBloc;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;

  setUp(() {
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    tvRecommendationsBloc = TVRecommendationsBloc(
      mockGetTVSeriesRecommendations,
    );
  });

  final tId = 1;
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

  blocTest<TVRecommendationsBloc, TVRecommendationsState>(
    "should change movies data when data is gotten successfully",
    build: () {
      when(
        mockGetTVSeriesRecommendations.execute(tId),
      ).thenAnswer((_) async => Right(tTVSeriesList));

      return tvRecommendationsBloc;
    },
    act: (bloc) {
      bloc.add(OnGetTVSeriesRecommendationsEvent(tId));
    },
    wait: const Duration(milliseconds: 100),
    expect: () => <TVRecommendationsState>[
      GetTVSeriesRecommendationsLoadingState(),
      GetTVSeriesRecommendationsHasDataState(tTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetTVSeriesRecommendations.execute(tId));
    },
  );
}
