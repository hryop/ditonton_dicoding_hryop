import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tMovieDetailResponse = MovieDetailResponse(
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
    budget: 1000,
    imdbId: '1',
    releaseDate: '1999-10-15',
    revenue: 1000,
    runtime: 1000,
    video: true,
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(readJson('dummy_data/movie_detail_response.json'));
      // act
      final result = MovieDetailResponse.fromJson(jsonMap);
      // assert
      expect(result, tMovieDetailResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tMovieDetailResponse.toJson();
      // assert
      final expectedJsonMap = {
        "adult": false,
        "backdrop_path": "backdropPath",
        "genres": [
          {
            "id": 1,
            "name": "Action"
          }
        ],
        "id": 1,
        "original_title": "originalTitle",
        "overview": "overview",
        "poster_path": "posterPath",
        "title": "title",
        "vote_average": 1,
        "vote_count": 1,
        "homepage": "homepage",
        "original_language": "originalLanguage",
        "popularity": 326.0995,
        "status": "status",
        "tagline": "tagline",
        "budget": 1000,
        "imdb_id": "1",
        "release_date": "1999-10-15",
        "revenue": 1000,
        "runtime": 1000,
        "video": true
      };
      expect(result, expectedJsonMap);
    });
  });
}
