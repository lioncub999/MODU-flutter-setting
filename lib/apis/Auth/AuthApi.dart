import 'package:http/src/response.dart';
import 'package:modu_flutter/apis/Auth/AuthModel.dart';
import 'package:modu_flutter/utils/axios.dart';

class AuthApi {
  static Future<Response> login(data) async {
    var response = await ApiService.postRequest("/auth/login", data);

    AuthInfo authInfo = new AuthInfo();
    print(response.body);
    return response;
  }

  static Future<Response> isValidToken(data) async {
    var response = await ApiService.postRequest("/auth/isValidToken", data);
    return response;
  }
  static Future<Response> register(data) async {
    var response = await ApiService.postRequest("/auth/register", data);
    return response;
  }
}