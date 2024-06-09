import 'package:dio/dio.dart';
import 'package:ghibli_app_flutter/src/services/dio_service.dart';

class DioServiceImp implements DioService {
  @override
  Dio getDio() {
    return Dio(BaseOptions(
        baseUrl: 'https://ghibliapi.vercel.app',
        headers: {'content-type': 'application/json;charset=ut-8'}));
  }
}
