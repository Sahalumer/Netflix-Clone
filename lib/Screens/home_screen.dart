import 'package:flutter/material.dart';
import 'package:netflixclone/Models/top_rated_series_model.dart';
import 'package:netflixclone/Models/upcoming_movie_model.dart';
import 'package:netflixclone/Services/api_services.dart';
import 'package:netflixclone/Widget/carousal_card_widget.dart';
import 'package:netflixclone/Widget/movie-card-widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();
  late Future<MovieModel> upComingFuture;
  late Future<MovieModel> nowPlayingFuture;
  late Future<TopRatedSeriesModel> topSeriesfuture;
  @override
  void initState() {
    super.initState();
    upComingFuture = _apiServices.getUpComingMovies();
    nowPlayingFuture = _apiServices.getNowPlayingMovies();
    topSeriesfuture = _apiServices.getTopRatedSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          "assets/logo.png",
          height: 70,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: Colors.blue[300],
              height: 27,
              width: 27,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          FutureBuilder(
            future: topSeriesfuture,
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                return CarousalCardWidget(data: snapShot.data!);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          SizedBox(
            height: 220,
            child: MovieCardWidget(
                future: nowPlayingFuture, headLine: "Now Playing Movies"),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 220,
            child: MovieCardWidget(
                future: upComingFuture, headLine: "Upcoming Movies"),
          )
        ],
      )),
    );
  }
}
