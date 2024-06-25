import 'package:modu_flutter/apis/ApiResponse.dart';

class LoginData extends ApiResponse{
  late String userLoginId;
  late String userPw;

  Map<String, dynamic> toJson() => {
    'userLoginId': userLoginId,
    'userPw': userPw,
  };
}

class AuthInfo extends ApiResponse{
  late String token;
  late String loginId;

  Map<String, dynamic> toJson() => {
    'token': token,
    'loginId' : loginId,
  };
}