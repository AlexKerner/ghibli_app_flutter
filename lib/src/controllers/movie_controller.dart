import 'package:flutter/material.dart';
import 'package:ghibli_app_flutter/src/models/movies_model.dart';
import 'package:ghibli_app_flutter/src/repositories/movies_repository.dart';

class MovieController {
  final MoviesRepository _moviesRepository;
  MovieController(this._moviesRepository) {
    fetch();
  }
  ValueNotifier<List<Movies>?> movies = ValueNotifier(null);

  List<Movies>? _cachedMovies;

  onChanged(String value) {
    if (_cachedMovies != null) {
      var filteredList = _cachedMovies!
          .where((movie) =>
              movie.title?.toLowerCase().contains(value.toLowerCase()) ?? false)
          .toList();
      movies.value = filteredList;
    }
  }

  fetch() async {
    movies.value = await _moviesRepository.getMovies();
    _cachedMovies = movies.value;
  }
}
