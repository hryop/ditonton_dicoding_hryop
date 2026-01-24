import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_airing_today_tv_series.dart';

import '../../helper/test_helper.mocks.dart';


void main() {
  late GetAiringTodayTVSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetAiringTodayTVSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TVSeries>[];

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getAiringTodayTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvSeries));
  });
}
