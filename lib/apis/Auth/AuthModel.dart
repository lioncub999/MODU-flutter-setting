import '../ApiResponse.dart';

class LoginData extends ApiResponse{
  String? userLoginId;
  String? userPw;

  Map<String, dynamic> toJson() => {
    'userLoginId': userLoginId,
    'userPw': userPw,
  };
}

class AuthInfo extends ApiResponse{
  String? token;
  String? userLoginId;

  Map<String, dynamic> toJson() => {
    'token': token,
    'userLoginId' : userLoginId,
  };
}