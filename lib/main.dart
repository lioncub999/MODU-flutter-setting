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
//TODO:┃     TalkStore.dart 토크 리스트 관리:talkList
//TODO:┃
//TODO:┃
//TODO:┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modu_flutter/apis/Auth/AuthModel.dart';
import 'package:modu_flutter/provider/MainStore.dart';
import 'package:modu_flutter/provider/TalkStore.dart';
import 'package:modu_flutter/ui/common/CupertinoDialog.dart';
import 'package:modu_flutter/utils/auth/auth_utils.dart';
import 'package:modu_flutter/view/auth/LoginPage.dart';
import 'package:modu_flutter/view/chat/ChatPage.dart';
import 'package:modu_flutter/view/setting/SettingPage.dart';
import 'package:modu_flutter/view/common/BottomNavbarUI.dart';
import 'package:modu_flutter/view/talk/TalkListPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apis/Auth/AuthApi.dart';

Future<void> main() async {
  // TODO: 플러터 환경 초기화
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: 환경 확인 후 환경변수 세팅 (Android || iOS ?)
  if (kIsWeb) {
    await dotenv.load(fileName: '.env.web_local');
  } else if (Platform.isIOS) {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    await dotenv.load(fileName: isProduction ? '.env.ios_prod' : '.env.ios_local');
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AuthUtils.checkTokenValidation(context);
  }

  @override
  Widget build(BuildContext context) {
    return [
      // TODO : 앱 실행 로그인 체크 default
      Scaffold(
        body: Center(
          child: Text("메인 페이지"), // 로고 이미지 넣으셈
        ),
      ),
      // TODO: 로그인, 회원가입 화면
      GestureDetector(
        onTap: FocusScope.of(context).unfocus, // 인풋 영역 밖 클릭시 키보드 닫기
        child: Scaffold(body: LoginPage()), //
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
