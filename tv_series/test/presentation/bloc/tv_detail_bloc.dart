import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TVDetailBloc tvDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvDetailBloc = TVDetailBloc(getTvSeriesDetail: mockGetTvSeriesDetail);
  });

  final tId = 1;

  blocTest<TVDetailBloc, TVDetailState>(
    "should change tv seriesdetail data when data is gotten successfully",
    build: (){
      when(mockGetTvSeriesDetail.execute(tId)).thenAnswer(
            (_) async => Right(testTvDetail),
      );

      return tvDetailBloc;
    },
    act: (bloc)=>bloc.add(OnGetTvSeriesDetailEvent(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => <TVDetailState>[
      GetTVSeriesDetailLoadingState(),
      GetTVSeriesDetailHasDataState(testTvDetail)
    ],
    verify: (bloc){
      verify(mockGetTvSeriesDetail.execute(tId));
    }
  );
}
