class LoginData {
  late String userLoginId;
  late String userPw;

  Map<String, dynamic> toJson() => {
    'userLoginId': userLoginId,
    'userPw': userPw,
  };
}

class AuthInfo {
  late String token;
  late String loginId;

  Map<String, dynamic> toJson() => {
    'token': token,
    'loginId' : loginId,
  };
}