import '../ApiResponse.dart';

class Talk extends ApiResponse{
  int? talkId;
  String? talkCont;
  String? userId;
  String? userNm;
  String? userGender;
  String? creDtm;

  Map<String, dynamic> toJson() => {
    'talkId' : talkId,
    'talkCont' : talkCont,
    'userId' : userId,
    'userNm' : userNm,
    'userGender' : userGender,
    'creDtm' : creDtm,
  };
}