import 'dart:convert';
import 'dart:typed_data';

import 'package:http/src/response.dart';
import 'package:modu_flutter/utils/axios/axios_utils.dart';

import 'TalkModel.dart';

class TalkApi {
  static Future<Map<String, dynamic>> getTalkList() async {
    var response = await ApiService.getRequest("/talk/list");
    return response;
  }

  static Future<Response> insertTalk(data) async{
    var response = await ApiService.postRequest("/talk/insert", data);
    var result = jsonDecode(response.body)["result"];

    List<Talk> talkList = result ;


    return response;
  }


}