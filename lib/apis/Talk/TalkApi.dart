import 'dart:convert';
import 'dart:typed_data';

import 'package:http/src/response.dart';
import 'package:modu_flutter/utils/axios/axios_utils.dart';

import '../ApiResponse.dart';
import 'TalkModel.dart';

class TalkApi {
  static Future<dynamic> getTalkList() async {
    var response = await ApiService.getRequest("/talk/list");
    var result = response['result'];

    return result;
  }

  static Future<Map<String, dynamic>> insertTalk(data) async{
    var response = await ApiService.postRequest("/talk/insert", data);

    ApiResponse apiResponse = new ApiResponse();
    apiResponse.ok = response["ok"];

    return response;
  }
}