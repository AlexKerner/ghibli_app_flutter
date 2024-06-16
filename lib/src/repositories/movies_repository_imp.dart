import 'package:ghibli_app_flutter/src/models/movies_model.dart';
import 'package:ghibli_app_flutter/src/repositories/movies_repository.dart';
import 'package:ghibli_app_flutter/src/services/dio_service.dart';
import 'package:ghibli_app_flutter/src/utils/api.utils.dart';

class MoviesRepositoryImp implements MoviesRepository {
  final DioService _dioService;

  MoviesRepositoryImp(this._dioService);

  @override
  Future<List<Movies>> getMovies() async {
    var response = await _dioService.getDio().get(API.REQUEST_MOVIE_LIST);
    List<dynamic> data = response.data;
    List<Movies> moviesList = data.map((movieJson) => Movies.fromJson(movieJson)).toList();
    return moviesList;
  }
}
