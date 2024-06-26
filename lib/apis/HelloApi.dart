import 'package:http/src/response.dart';
import 'package:modu_flutter/utils/axios/axios_utils.dart';

class HelloApi {
  static Future<Response> getHello() async{
    var response = await ApiService.getRequest('/hello');
    return response;
  }
  
  static Future<Response> postHello(data) async {
    var response = await ApiService.postRequest('/auth/login', data);
    return response;
  }
}