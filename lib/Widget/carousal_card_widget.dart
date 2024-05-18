import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflixclone/Common/common.dart';
import 'package:netflixclone/Models/top_rated_series_model.dart';

class CarousalCardWidget extends StatelessWidget {
  final TopRatedSeriesModel data;
  const CarousalCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * .33 < 300) ? 300 : size.height * .33,
      child: GestureDetector(
        onTap: () {},
        child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (context, index, realIndex) {
            var url = data.results[index].backdropPath.toString();
            return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  CachedNetworkImage(
                    imageUrl: "$imgUrl$url",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(data.results[index].name)
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: (size.height * 0.33 < 300) ? 300 : size.height * .30,
            aspectRatio: 16 / 9,
            reverse: false,
            initialPage: 0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}
