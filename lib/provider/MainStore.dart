// TODO: MainStore (Provider)
import 'package:flutter/cupertino.dart';

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