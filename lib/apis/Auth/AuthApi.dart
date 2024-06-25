import 'dart:convert';

import 'package:http/src/response.dart';
import 'package:modu_flutter/apis/Auth/AuthModel.dart';
import 'package:modu_flutter/utils/axios.dart';

class AuthApi {
  static Future<AuthInfo> login(data) async {
    var response = await ApiService.postRequest("/auth/login", data);
    var result = jsonDecode(response.body)['result'];

    AuthInfo authInfo = new AuthInfo();
    authInfo.token = result['token'];
    authInfo.loginId = result['loginId'];

    return authInfo;
  }

  static Future<Response> isValidToken(data) async {
    var response = await ApiService.postRequest("/auth/isValidToken", data);
    print(response);

    return response;
  }
  static Future<Response> register(data) async {
    var response = await ApiService.postRequest("/auth/register", data);
    return response;
  }
}