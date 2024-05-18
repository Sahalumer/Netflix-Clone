import 'dart:convert';

import 'package:netflixclone/Common/common.dart';
import 'package:netflixclone/Models/top_rated_series_model.dart';
import 'package:netflixclone/Models/upcoming_movie_model.dart';
import 'package:http/http.dart' as http;

const key = "?api_key=$apikey";
late String endPoint;

class ApiServices {
  Future<MovieModel> getUpComingMovies() async {
    endPoint = upComingMovieEndPoint;
    final url = '$baseUrl$endPoint$key';
    final _response = await http.get(Uri.parse(url));

    if (_response.statusCode == 200) {
      return MovieModel.fromJson(jsonDecode(_response.body));
    } else {
      throw Exception("Failed to Load Upcoming Movies");
    }
  }

  Future<MovieModel> getNowPlayingMovies() async {
    endPoint = noePlayingMovieEndPoint;
    final url = '$baseUrl$endPoint$key';
    final _response = await http.get(Uri.parse(url));

    if (_response.statusCode == 200) {
      return MovieModel.fromJson(jsonDecode(_response.body));
    } else {
      throw Exception("Failed to Load Now Playing Movies");
    }
  }

  Future<TopRatedSeriesModel> getTopRatedSeries() async {
    endPoint = topRaterSeriesEndPoint;
    final url = '$baseUrl$endPoint$key';
    final _response = await http.get(Uri.parse(url));

    if (_response.statusCode == 200) {
      return TopRatedSeriesModel.fromJson(jsonDecode(_response.body));
    } else {
      throw Exception("Failed to Load Top Rated Series");
    }
  }
}
