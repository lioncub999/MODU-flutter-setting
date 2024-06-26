import 'dart:convert';

import 'package:modu_flutter/apis/ApiResponse.dart';
import 'package:modu_flutter/apis/Auth/AuthModel.dart';
import 'package:modu_flutter/utils/axios/axios_utils.dart';

class AuthApi {
  static Future<AuthInfo> login(data) async {
    var response = await ApiService.postRequest("/auth/login", data);
    var result = jsonDecode(response.body)['result'];

    AuthInfo authInfo = new AuthInfo();
    authInfo.token = result['token'];
    authInfo.userLoginId = result['userLoginId'];

    return authInfo;
  }

  static Future<ApiResponse> isValidToken(data) async {
    var response = await ApiService.postRequest("/auth/isValidToken", data);
    var result = jsonDecode(response.body);

    ApiResponse apiResponse = new ApiResponse();
    apiResponse.ok = result["ok"];

    return apiResponse;
  }

  static Future<ApiResponse> register(data) async {
    var response = await ApiService.postRequest("/auth/register", data);
    var result = jsonDecode(response.body);

    ApiResponse apiResponse = new ApiResponse();
    apiResponse.ok = result["ok"];

    return apiResponse;
  }
}