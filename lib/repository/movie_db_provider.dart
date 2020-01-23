import 'package:dio/dio.dart';
import 'package:movie_app/constants/movie_db_provider_const.dart';
import 'package:movie_app/data/movie_model.dart';
import 'package:movie_app/data/provider/movies_notifier.dart';

class MovieDBProvider {
  void discoverMovies() async {
    try {
      Response response = await Dio().get(
          '$MOVIE_DB_SERVER_HOST/3/discover/movie',
          queryParameters: {API_KEY: API_KEY_VALUE, LANG: "en-US"});
      List<MovieModel> movies = [];
      for (dynamic movie in response.data['results']) {
        movies.add(MovieModel.fromJson(movie));
      }
      moviesNotifier.movies = movies;
    } catch (e) {
      print(e);
    }
  }
}

MovieDBProvider movieDBProvider = MovieDBProvider();
