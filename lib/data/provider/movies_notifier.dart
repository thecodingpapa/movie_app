import 'package:flutter/material.dart';
import 'package:movie_app/data/movie_model.dart';

class MoviesNotifier extends ChangeNotifier {
  List<MovieModel> _movies = [];

  List<MovieModel> get movies => _movies;
  set movies(List<MovieModel> newMovies) {
    _movies.clear();
    _movies.addAll(newMovies);
    notifyListeners();
  }
}

MoviesNotifier moviesNotifier = MoviesNotifier();
