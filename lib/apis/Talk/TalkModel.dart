import '../ApiResponse.dart';

class Talk extends ApiResponse{
  int? talkId;
  String? talkCont;
  String? userId;
  String? userNm;
  String? userGender;
  String? creDtm;

  Talk({
    this.talkId,
    this.talkCont,
    this.userId,
    this.userNm,
    this.userGender,
    this.creDtm,
  });

  // fromJson 생성자 추가
  factory Talk.fromJson(Map<String, dynamic> json) {
    return Talk(
      talkId: json['talkId'],
      talkCont: json['talkCont'],
      userId: json['userId'],
      userNm: json['userNm'],
      userGender: json['userGender'],
      creDtm: json['creDtm'],
    );
  }

  Map<String, dynamic> toJson() => {
    'talkId' : talkId,
    'talkCont' : talkCont,
    'userId' : userId,
    'userNm' : userNm,
    'userGender' : userGender,
    'creDtm' : creDtm,
  };
}