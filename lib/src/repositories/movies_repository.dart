import 'package:ghibli_app_flutter/src/models/movies_model.dart';

abstract class MoviesRepository {
  Future<List<Movies>> getMovies();
}