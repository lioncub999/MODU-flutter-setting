import 'package:http/src/response.dart';
import 'package:modu_flutter/utils/axios.dart';

class TalkApi {
  static Future<Response> insertTalk(data) async{
    var response = await ApiService.postRequest("/talk/insert", data);
    return response;
  }

  static Future<Response> getTalkList() async {
    var response = await ApiService.getRequest("/talk/list");
    return response;
  }
}