import 'package:dio/dio.dart';


enum MethodAPI { POST, PUT, GET, PATCH, DELETE }

abstract class BaseService {
  final Dio client;

  BaseService(this.client);

}
