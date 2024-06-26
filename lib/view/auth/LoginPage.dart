import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modu_flutter/apis/Auth/AuthApi.dart';
import 'package:modu_flutter/apis/Auth/AuthModel.dart';
import 'package:modu_flutter/ui/common/Inputs.dart';
import 'package:modu_flutter/view/auth/register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../../provider/MainStore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  String userLoginId = "";
  String userPw = "";

  Login() async {
    try {
      LoginData loginData = new LoginData();
      loginData.userLoginId = userLoginId;
      loginData.userPw = userPw;

      final AuthInfo authInfo = await AuthApi.login(loginData.toJson());

      // TODO: 토큰 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', authInfo.token.toString());
      await prefs.setString('userLoginId', authInfo.userLoginId.toString());

      // TODO: 로그인 완료 후 페이지 이동
      context.read<MainStore>().setIsLogin(2);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("MODU_CHAT_LOGIN"),
          Container(
              width: 300,
              child: Column(
                children: [
                  UIInput(
                      labelText: "UserId",
                      obscureText: false,
                      onChangedFunc: (value) {
                        setState(() {
                          userLoginId = value;
                        });
                      }),
                  UIInput(
                      labelText: "UserPw",
                      obscureText: true,
                      onChangedFunc: (value) {
                        setState(() {
                          userPw = value;
                        });
                      }),
                  UIButton(
                      height: 50,
                      color: Colors.blue,
                      onPressedFunc: () {
                        Login();
                      },
                      buttonText: "로그인"),
                  UIButton(
                      height: 50,
                      color: Colors.blue,
                      onPressedFunc: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Register()),
                        );
                      },
                      buttonText: "회원가입"),
                ],
              ))
        ],
      ),
    );
  }
}
