import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:modu_flutter/view/bodycont/main/mainpage.dart';
import 'package:modu_flutter/view/bodycont/sub/sub1page.dart';
import 'package:modu_flutter/view/bodycont/sub/subpage.dart';
import 'package:modu_flutter/view/layout/appbar/appbarUI.dart';
import 'package:modu_flutter/view/layout/bottombar/bottombarUI.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 환경 초기화

  if(kIsWeb) {
    await dotenv.load(fileName: '.env.web_local');
  } else if (Platform.isIOS) {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    await dotenv.load(fileName: isProduction ? '.env.ios_prod' : '.env.ios_local');
  }

  runApp(ChangeNotifierProvider(
    create: (c) => MainStore(),
    child: MaterialApp(
        theme: ThemeData(
          splashFactory: NoSplash.splashFactory,  // Ripple Effect 비활성화
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
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var fromGetData;
  var fromPostData;
  setFromGetData(data) {
    setState(() {
      fromGetData = data;
    });
  }
  setFromPostData(data) {
    setState(() {
      fromPostData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUI(
        title: "TITLE",setFromGetData:setFromGetData,setFromPostData:setFromPostData
      ),
      body: [
        Mainpage(fromGetData:fromGetData, fromPostData:fromPostData),
        Subpage(),
        Sub1page()]
      [context.watch<MainStore>().tapState],
      bottomNavigationBar: BottomBarUI(),
    );
  }
}
