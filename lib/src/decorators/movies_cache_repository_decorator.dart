import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ghibli_app_flutter/src/decorators/movies_repository_decorator.dart';
import 'package:ghibli_app_flutter/src/models/movies_model.dart';

class MoviesCacheRepositoryDecorator extends MoviesRepositoryDecorator {
  MoviesCacheRepositoryDecorator(super.moviesRepository);

  @override
  Future<List<Movies>> getMovies() async {
    try {
      List<Movies> movies = await super.getMovies();
      await _saveInCache(movies);
      return movies;
    } catch (e) {
      return _getInCache();
    }
  }

  Future<void> _saveInCache(List<Movies> movies) async {
    var prefs = await SharedPreferences.getInstance();
    String jsonMovies =
        jsonEncode(movies.map((movie) => movie.toJson()).toList());
    await prefs.setString('movies_cache', jsonMovies);
    print(
        'Movies saved in cache: ${movies.map((movie) => movie.toJson()).toList()}');
  }

  Future<List<Movies>> _getInCache() async {
    var prefs = await SharedPreferences.getInstance();
    var moviesJsonString = prefs.getString('movies_cache');
    if (moviesJsonString != null) {
      List<dynamic> jsonList = jsonDecode(moviesJsonString);
      List<Movies> movies =
          jsonList.map((json) => Movies.fromJson(json)).toList();
      print(
          'Movies retrieved from cache: ${movies.map((movie) => movie.toJson()).toList()}');
      return movies;
    } else {
      return [];
    }
  }
}
