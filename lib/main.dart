//TODO:┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//TODO:┃
//TODO:┃  <CurrentPage>
//TODO:┃     ● 앱 처음 실행 페이지 - 환경 체크 및 환경 변수 설정 (kIsWeb)
//TODO:┃     ● initState : checkTokenValid(토큰 유효성 검증)
//TODO:┃     ● _InvalidTokenAlert : 토큰 유효 하지 않을 시 alert
//TODO:┃
//TODO:┃
//TODO:┃  <Providers>
//TODO:┃     MainStore 하단바:tapState, 로그인 상태:isLogin
//TODO:┃     TalkStore 토크 리스트 관리:talkList
//TODO:┃
//TODO:┃
//TODO:┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modu_flutter/view/auth/login.dart';
import 'package:modu_flutter/view/talk/TalkListPage.dart';
import 'package:modu_flutter/view/chat/ChatPage.dart';
import 'package:modu_flutter/view/setting/SettingPage.dart';
import 'package:modu_flutter/view/common/BottomNavbarUI.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis/Auth/AuthApi.dart';
import 'apis/TalkApi.dart';

Future<void> main() async {
  // TODO: 플러터 환경 초기화
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: 환경 확인 후 환경변수 세팅 (Android || iOS ?)
  if (kIsWeb) {
    await dotenv.load(fileName: '.env.web_local');
  } else if (Platform.isIOS) {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    await dotenv.load(
        fileName: isProduction ? '.env.ios_prod' : '.env.ios_local');
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (c) => MainStore()),
      ChangeNotifierProvider(create: (c) => TalkStore()),
    ],
    child: MaterialApp(
        theme: ThemeData(
          splashFactory: NoSplash.splashFactory, // Ripple Effect 비활성화
        ),
        // TODO : debug 딱지 때기
        debugShowCheckedModeBanner: false,
        home: MyApp()),
  ));
}

// TODO: MainStore (Provider)
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
}
// TODO: TalkStore (Provider)
class TalkStore extends ChangeNotifier {
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

  // TODO : 현재 토큰 검증
  checkTokenValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('jwtToken');
    var loginId = prefs.getString('loginId');
    if (token == null) {
      context.read<MainStore>().setIsLogin(1); // 토큰 없으면 로그인 페이지로 이동
    } else {
      try {
        final result =
            await AuthApi.isValidToken({"token": token, "loginId": loginId}); // token, loginId 로 토큰 검증 (유효 : true, 유효하지 않으면 Exception)
        bool isValid = jsonDecode(result.body);
        if (isValid) {
          context.read<MainStore>().setIsLogin(2); // 토큰 유효하면 메인페이지로 이동
        } else {
          context.read<MainStore>().setIsLogin(1);
        }
      } catch (e) {
        context.read<MainStore>().setIsLogin(1); // 토큰 검증 Exception 처리 시 로그인 페이지 보내고, token, loginId 삭제 후 알림
        prefs.remove('jwtToken');
        prefs.remove('loginId');
        _InvalidTokenAlert();
      }
    }
  }
  // TODO : 토큰 유효하지 않을시 알림
  void _InvalidTokenAlert() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("알림"),
            content: Text("인증 정보가 만료되었습니다. 재 로그인 해주세요."),
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
          child: Image.asset('ralo.jpeg'), // 로고 이미지 넣으셈
        ),
      ),
      // TODO: 로그인, 회원가입 화면
      GestureDetector(
        onTap: FocusScope.of(context).unfocus, // 인풋 영역 밖 클릭시 키보드 닫기
        child: Scaffold(body: Login()), //
      ),
      // TODO: 로그인 완료시 메인
      Scaffold(
        body: [
          TalkListPage(), // TalkPage
          ChatPage(), // ChatPage
          SettingPage() // SettingPage
        ][context.watch<MainStore>().tapState],
        bottomNavigationBar: BottomNavbarUI(), // 하단바
      )
    ][context.watch<MainStore>().isLogin];
  }
}
