import 'dart:convert';
import 'dart:typed_data';

import 'package:http/src/response.dart';
import 'package:modu_flutter/utils/axios/axios_utils.dart';

import 'TalkModel.dart';

class TalkApi {
  static Future<String> getTalkList() async {
    var response = await ApiService.getRequest("/talk/list");
    var result = utf8.decode(response.bodyBytes);

    print(json.decode(result)['result']);

    return result;
  }

  static Future<Response> insertTalk(data) async{
    var response = await ApiService.postRequest("/talk/insert", data);
    var result = jsonDecode(response.body)["result"];

    List<Talk> talkList = result ;


    return response;
  }


}