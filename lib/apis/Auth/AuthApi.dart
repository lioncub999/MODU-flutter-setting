import 'dart:convert';

import 'package:modu_flutter/apis/ApiResponse.dart';
import 'package:modu_flutter/apis/Auth/AuthModel.dart';
import 'package:modu_flutter/utils/axios/axios_utils.dart';

class AuthApi {
  static Future<AuthInfo> login(data) async {
    var response = await ApiService.postRequest("/auth/login", data);
    var result = response['result'];

    AuthInfo authInfo = new AuthInfo();
    authInfo.token = result['token'];
    authInfo.userLoginId = result['userLoginId'];

    return authInfo;
  }

  static Future<ApiResponse> isValidToken(data) async {
    var response = await ApiService.postRequest("/auth/isValidToken", data);
    var result = response['ok'];

    ApiResponse apiResponse = new ApiResponse();
    apiResponse.ok = result;

    return apiResponse;
  }

  static Future<ApiResponse> register(data) async {
    var response = await ApiService.postRequest("/auth/register", data);

    ApiResponse apiResponse = new ApiResponse();
    apiResponse.ok = response["ok"];

    return apiResponse;
  }
}