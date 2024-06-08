import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modu_flutter/apis/AuthApi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String loginId = "";
  String loginPw = "";

  void Login(loginInfo) async{
    try {
      final response = await AuthApi.login(loginInfo);
      final data = jsonDecode(response.body);
      final newToken = data['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwtToken', newToken);
      await prefs.setString('loginId', loginId);
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
                  loginId = value;
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
                  loginPw = value;
                });
              },
            ),
          ),
          Container(
              width: 300,
              height: 50,
              child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    Login({
                      "loginId" : loginId,
                      "loginPw" : loginPw
                    });
                  },
                  child: Text(
                    "로그인",
                    style: TextStyle(color: Colors.white),
                  )))
        ],
      ),
    );
  }
}
