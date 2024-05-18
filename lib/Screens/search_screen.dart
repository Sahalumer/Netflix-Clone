import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/Common/common.dart';
import 'package:netflixclone/Models/popular_movies_reccomendational_model.dart';
import 'package:netflixclone/Models/search_movie_model.dart';
import 'package:netflixclone/Services/api_services.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiServices _apiServices = ApiServices();
  late Future<PopularMovieReccomandational> movieRecFuture;
  TextEditingController searchController = TextEditingController();
  SearchMovieModel? searchMovieModel;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    movieRecFuture = _apiServices.getPopularMovies();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void search(String query) {
    _apiServices.getSearchedMovies(query).then((value) {
      setState(() {
        searchMovieModel = value;
      });
    }).catchError((error) {
      print(error);
    });
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        search(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoSearchTextField(
                controller: searchController,
                onChanged: onSearchChanged,
                padding: const EdgeInsets.all(10),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
              ),
              searchController.text.isEmpty
                  ? FutureBuilder<PopularMovieReccomandational>(
                      future: movieRecFuture,
                      builder: (context, snapShot) {
                        if (snapShot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapShot.hasError) {
                          return const Center(
                              child: Text('Error loading data'));
                        } else if (snapShot.hasData) {
                          final data = snapShot.data!.results;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Top Searches",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 15),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 170,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.network(
                                              "$imgUrl${data[index].posterPath}"),
                                          const SizedBox(width: 20),
                                          SizedBox(
                                            width: 220,
                                            child: Text(
                                              data[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return const Center(child: Text('Not Found'));
                        }
                      },
                    )
                  : searchMovieModel != null
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 1.2 / 2),
                          itemCount: searchMovieModel!.results.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Column(
                                children: [
                                  searchMovieModel!
                                              .results[index].backdropPath !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              "$imgUrl${searchMovieModel!.results[index].backdropPath}",
                                          height: 170,
                                        )
                                      : Image.asset(
                                          "assets/netflix.png",
                                          height: 170,
                                        ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      searchMovieModel!
                                          .results[index].originalTitle,
                                      style: const TextStyle(fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
