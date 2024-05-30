import 'package:http/src/response.dart';
import 'package:modu_flutter/utils/axios.dart';

class HelloApi {
  static Future<Response> getHello() async{
    var response = await ApiService.getRequest('/test');
    return response;
  }
  
  static Future<Response> postHello(url, data) async {
    var response = await ApiService.postRequest(url, data);
    return response;
  }
}