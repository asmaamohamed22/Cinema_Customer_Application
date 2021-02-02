import 'package:cinema_customer_app/constant.dart';
import 'package:cinema_customer_app/screens/movie-details.dart';
import 'package:cinema_customer_app/vendor/movie.dart';
import 'package:cinema_customer_app/widgethome/functions.dart';
import 'package:flutter/material.dart';

Widget moviesView(String pCategory, List<Movie> allMovies) {
  List<Movie> movies;
  movies = getmovieByCategory(pCategory, allMovies);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.7),
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {
          print("---> ${movies[index].seats.toString()}");
          Navigator.pushNamed(context, MovieDetails.id,
              arguments: movies[index]);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Stack(
            children: [
              Positioned.fill(
                child: movies[index].pImage == null
                    ? Container()
                    : Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(movies[index].pImage),
                      ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: Colors.black87,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movies[index].pTitle,
                          style: TextStyle(
                            color: kBackground,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 6),
                        Row(
                          children: [
                            Text(
                              movies[index].pMovieTime,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    itemCount: movies.length,
  );
}
