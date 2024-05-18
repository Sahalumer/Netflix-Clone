import 'dart:convert';

import 'package:netflixclone/Common/common.dart';
import 'package:netflixclone/Models/popular_movies_reccomendational_model.dart';
import 'package:netflixclone/Models/search_movie_model.dart';
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

  Future<PopularMovieReccomandational> getPopularMovies() async {
    endPoint = poularMovieEndPoint;
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PopularMovieReccomandational.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Popular Movies');
    }
  }

  Future<SearchMovieModel> getSearchedMovies(String query) async {
    endPoint = "search/movie?query=$query";
    final url = "$baseUrl$endPoint";

    final response = await http.get(Uri.parse(url), headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2N2FhODhlNzVkMmU0MjViNzgwNTFmMmQyZjgxMmUxNyIsInN1YiI6IjY2NDMwMjViZTMzNmM5OTNmMzJhNTA1NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-j15LzbT9za4-cKICsahizGP1q5bpebPV0B8fYPa-mI"
    });

    if (response.statusCode == 200) {
      return SearchMovieModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Search Movie');
    }
  }
}
