import '../ApiResponse.dart';

class LoginData extends ApiResponse{
  String? userLoginId;
  String? userPw;

  Map<String, dynamic> toJson() => {
    'userLoginId': userLoginId,
    'userPw': userPw,
  };
}

class RegisterData extends ApiResponse {
  String? userLoginId;
  String? userPw;
  String? userNm;
  String? userEmail;
  String? userGender;
  String? userBirthday;

  Map<String, dynamic> toJson() => {
    'userLoginId' :userLoginId,
    'userPw' : userPw,
    'userNm' : userNm,
    'userEmail' : userEmail,
    'userGender' : userGender,
    'userBirthday' : userBirthday,
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