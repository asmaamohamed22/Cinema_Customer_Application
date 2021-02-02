import 'package:cinema_customer_app/vendor/movie.dart';

List<Movie> getmovieByCategory(String mAction, List<Movie> allMovies) {
  List<Movie> movies = [];
  try {
    for (var movie in allMovies) {
      if (movie.pCategory == mAction) {
        movies.add(movie);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return movies;
}
