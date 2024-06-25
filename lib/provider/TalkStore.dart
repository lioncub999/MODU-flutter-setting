// TODO: TalkStore (Provider)
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../apis/TalkApi.dart';

class TalkStore extends ChangeNotifier {
  var talkList;
  getTalkList() async {
    final result = await TalkApi.getTalkList();
    talkList = jsonDecode(utf8.decode(result.bodyBytes));
    notifyListeners();
  }
}