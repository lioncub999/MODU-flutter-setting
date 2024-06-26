import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modu_flutter/function/auth/AuthFnc.dart';
import 'package:modu_flutter/provider/MainStore.dart';
import 'package:modu_flutter/provider/TalkStore.dart';
import 'package:modu_flutter/view/auth/LoginPage.dart';
import 'package:modu_flutter/view/chat/ChatPage.dart';
import 'package:modu_flutter/view/setting/SettingPage.dart';
import 'package:modu_flutter/view/common/BottomNavbar.dart';
import 'package:modu_flutter/view/talk/main/TalkPage.dart';
import 'package:provider/provider.dart';

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
    AuthFnc.checkTokenValidation(context);
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
          // TODO: BottomNav - Tap - TalkPage
          TalkPage(),
          // TODO: BottomNav - Tap - ChatPage
          ChatPage(),
          // TODO: BottomNav - Tap - SettingPage
          SettingPage(),
        ][context.watch<MainStore>().tapState],

        //TODO: 공통 BottomNavbar
        bottomNavigationBar: BottomNavbar(),
      )
    ][context.watch<MainStore>().isLogin];
  }
}
