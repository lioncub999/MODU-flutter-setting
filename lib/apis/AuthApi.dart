import 'package:http/src/response.dart';
import 'package:modu_flutter/utils/axios.dart';

class AuthApi {
  static Future<Response> login(data) async {
    var response = await ApiService.postRequest("/auth/login", data);
    return response;
  }
}