import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_series_season_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvSeriesDetailResponse = TvSeriesDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [GenreModel(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
    homepage: 'homepage',
    originalLanguage: 'originalLanguage',
    popularity: 326.0995,
    status: 'status',
    tagline: 'tagline',
    seasons: [
      TvSeriesSeasonModel(
          airDate: '2012-08-26',
          episodeCount: 6,
          seasonName: 'Specials',
          posterPath: "posterPath")
    ],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_detail_response.json'));
      // act
      final result = TvSeriesDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesDetailResponse.toJson();
      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "backdropPath",
        "genres": [
          {"id": 1, "name": "Action"}
        ],
        "id": 1,
        "original_name": "originalTitle",
        "overview": "overview",
        "poster_path": "posterPath",
        "name": "title",
        "vote_average": 1,
        "vote_count": 1,
        "homepage": "homepage",
        "original_language": "originalLanguage",
        "popularity": 326.0995,
        "status": "status",
        "tagline": "tagline",
        "seasons": [
          {
            "air_date": "2012-08-26",
            "episode_count": 6,
            "name": "Specials",
            "poster_path": "posterPath"
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
