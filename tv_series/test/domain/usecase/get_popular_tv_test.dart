import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_popular_tv_series.dart';

import '../../helper/test_helper.mocks.dart';


void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TVSeries>[];

  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvSeriesRepository.getPopularTvSeries())
            .thenAnswer((_) async => Right(tTvSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvSeries));
      });
    });
  });
}
