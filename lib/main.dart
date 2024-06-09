import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modu_flutter/view/auth/login.dart';
import 'package:modu_flutter/view/bodycont/main/mainpage.dart';
import 'package:modu_flutter/view/bodycont/sub/sub1page.dart';
import 'package:modu_flutter/view/bodycont/sub/subpage.dart';
import 'package:modu_flutter/view/layout/appbar/appbarUI.dart';
import 'package:modu_flutter/view/layout/bottombar/bottombarUI.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis/AuthApi.dart';
import 'apis/TalkApi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 환경 초기화

  if (kIsWeb) {
    await dotenv.load(fileName: '.env.web_local');
  } else if (Platform.isIOS) {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    await dotenv.load(
        fileName: isProduction ? '.env.ios_prod' : '.env.ios_local');
  }

  runApp(ChangeNotifierProvider(
    create: (c) => MainStore(),
    child: MaterialApp(
        theme: ThemeData(
          splashFactory: NoSplash.splashFactory, // Ripple Effect 비활성화
        ),
        // TODO : debug 딱지 때기
        debugShowCheckedModeBanner: false,
        home: MyApp()),
  ));
}

class MainStore extends ChangeNotifier {
  int tapState = 0;

  setTapState(tap) {
    tapState = tap;
    notifyListeners();
  }

  int isLogin = 0;

  setIsLogin(state) {
    isLogin = (state);
    notifyListeners();
  }

  var talkList;
  getTalkList() async {
    final result = await TalkApi.getTalkList();
    talkList = jsonDecode(utf8.decode(result.bodyBytes));
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkTokenValid();
  }

  //
  checkTokenValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwtToken');
    var loginId = prefs.getString('loginId');
    if (token == null) {
      context.read<MainStore>().setIsLogin(1);
    } else {
      try {
        final result =
            await AuthApi.isValidToken({"token": token, "loginId": loginId});
        bool isValid = jsonDecode(result.body);
        if (isValid) {
          context.read<MainStore>().setIsLogin(2);
        } else {
          context.read<MainStore>().setIsLogin(1);
        }
      } catch (e) {
        context.read<MainStore>().setIsLogin(1);
        prefs.remove('jwtToken');
        prefs.remove('loginId');
        _showAlert();
      }
    }
  }

  void _showAlert() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("알림"),
            content: Text("인증 정보가 만료되었습니다."),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("확인"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return [
      // TODO : 앱 실행 로그인 체크 default
      Scaffold(
        body: Center(
          child: Image.asset('ralo.jpeg'),
        ),
      ),
      // TODO: 로그인, 회원가입 화면
      GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(body: Login()),
      ),
      // TODO: 로그인 완료시 메인
      Scaffold(
        appBar: AppBarUI(
          title: "TITLE",
        ),
        body: [
          Mainpage(),
          Subpage(),
          Sub1page()
        ][context.watch<MainStore>().tapState],
        bottomNavigationBar: BottomBarUI(),
      )
    ][context.watch<MainStore>().isLogin];
  }
}
