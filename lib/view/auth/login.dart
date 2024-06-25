import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modu_flutter/apis/Auth/AuthApi.dart';
import 'package:modu_flutter/apis/Auth/AuthModel.dart';
import 'package:modu_flutter/view/auth/register.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String userLoginId = "";
  String userPw = "";

  void Login(loginInfo) async{
    try {
      LoginData loginData = new LoginData();
      loginData.userLoginId = userLoginId;
      loginData.userPw = userPw;

      final AuthInfo authInfo = await AuthApi.login(loginData.toJson());
      final newToken = authInfo.token;

      // TODO: 토큰 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', newToken);
      await prefs.setString('userLoginId', userLoginId);

      // TODO: 로그인 완료 후 페이지 이동
      context.read<MainStore>().setIsLogin(2);
    } catch(e) {
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
            margin: EdgeInsets.only(bottom: 20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'UserId',
              ),
              onChanged: (value) {
                setState(() {
                  userLoginId = value;
                });
              },
            ),
          ),
          Container(
            width: 300,
            margin: EdgeInsets.only(bottom: 20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (value) {
                setState(() {
                  userPw = value;
                });
              },
            ),
          ),
          Container(
              width: 300,
              child: Column(
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
                          Login({
                            "userLoginId" : userLoginId,
                            "userPw" : userPw
                          });
                        },
                        child: Text(
                          "로그인",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  Container(
                    width: 300,
                    height: 50,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text(
                          "회원가입",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
