import 'package:ghibli_app_flutter/src/models/movies_model.dart';
import 'package:ghibli_app_flutter/src/repositories/movies_repository.dart';

class MoviesRepositoryDecorator implements MoviesRepository{

  final MoviesRepository _moviesRepository;

  MoviesRepositoryDecorator(this._moviesRepository );
  
  @override
  Future<List<Movies>> getMovies() async {
    return await _moviesRepository.getMovies();
  }
  
}