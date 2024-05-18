// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:netflixclone/Common/common.dart';
import 'package:netflixclone/Models/upcoming_movie_model.dart';

class MovieCardWidget extends StatefulWidget {
  final Future<MovieModel> future;
  final String headLine;
  const MovieCardWidget(
      {super.key, required this.future, required this.headLine});

  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.future,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            final data = snapShot.data!.results;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.headLine,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:
                              Image.network("$imgUrl${data[index].posterPath}"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
