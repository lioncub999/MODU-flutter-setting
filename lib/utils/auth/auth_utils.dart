// auth_utils.dart
import 'package:flutter/material.dart';
import 'package:modu_flutter/apis/ApiResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../apis/Auth/AuthApi.dart';
import '../../apis/Auth/AuthModel.dart';
import '../../provider/MainStore.dart';
import '../../ui/common/CupertinoDialog.dart';

class AuthUtils {
  static Future<void> checkTokenValidation(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('jwtToken') == null || prefs.getString('userLoginId') == null) {
      context.read<MainStore>().setIsLogin(1); // 토큰 null OR 유저아이디 null 이면 로그인 페이지로 이동
    } else {
      AuthInfo authInfo = new AuthInfo();
      authInfo.token = prefs.getString('jwtToken');
      authInfo.userLoginId = prefs.getString('userLoginId');

      final ApiResponse checkValid = await AuthApi.isValidToken(authInfo.toJson()); // token, loginId 로 토큰 검증 (유효 : true, 유효하지 않으면 false)

      if (checkValid.ok) {
        context.read<MainStore>().setIsLogin(2); // 토큰 유효하면 메인페이지로 이동
      } else {
        context.read<MainStore>().setIsLogin(1); // 토큰 검증 false 시 로그인 페이지 보내고, token, userLoginId 삭제 후 알림
        prefs.remove('jwtToken');
        prefs.remove('userLoginId');
        CupertinoDialog.showAlert(context, "알림", "인증 정보가 만료 되었습니다.", "확인");
      }
    }
  }
}

