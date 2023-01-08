import 'package:dio/dio.dart';

class API
{
  String baseURL = "https://jsonplaceholder.typicode.com/todos";


  Future<List> getTodos() async
  {
    try {
      var response = await Dio().get(baseURL,queryParameters: {"_limit":5});
      print(response);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }

}