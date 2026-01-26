import 'dart:convert';

import 'package:core/utils/constants.dart';
import 'package:core/utils/exception.dart';
import 'package:core/data/models/tv/tv_series_detail_model.dart';
import 'package:core/data/models/tv/tv_series_model.dart';
import 'package:core/data/models/tv/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TVSereisRemoteDataSource {
  Future<List<TvSeriesModel>> getAiringTodayTvSeries();

  Future<List<TvSeriesModel>> getPopularTvSeries();

  Future<List<TvSeriesModel>> getTopRatedTvSeries();

  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);

  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id);

  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TVSereisRemoteDataSourceImpl implements TVSereisRemoteDataSource {
  final http.Client client;

  TVSereisRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getAiringTodayTvSeries() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/airing_today?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/popular?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/top_rated?$apiKey'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TvSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendations(int id) async {
    String url = '$baseUrl/tv/$id/recommendations?$apiKey';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(
      Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'),
    );

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
