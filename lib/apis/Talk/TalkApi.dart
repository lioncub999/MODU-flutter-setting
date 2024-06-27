import 'package:modu_flutter/utils/axios/axios_utils.dart';

import '../ApiResponse.dart';
import 'TalkModel.dart';

class TalkApi {
  static Future<List<Talk>> getTalkList() async {
    var response = await ApiService.getRequest("/talk/list");
    var result = response['result'];

    // JSON 데이터를 List<Talk>로 변환
    List<Talk> talkList = (result as List).map((json) => Talk.fromJson(json)).toList();

    return talkList;
  }

  static Future<Map<String, dynamic>> insertTalk(data) async{
    var response = await ApiService.postRequest("/talk/insert", data);

    ApiResponse apiResponse = new ApiResponse();
    apiResponse.ok = response["ok"];

    return response;
  }
}