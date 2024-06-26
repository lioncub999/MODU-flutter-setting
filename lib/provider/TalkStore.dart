// TODO: TalkStore (Provider)
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:modu_flutter/apis/Talk/TalkModel.dart';

import '../apis/Talk/TalkApi.dart';

class TalkStore extends ChangeNotifier {
  List<dynamic> talkList = [];
  getTalkList() async {
    talkList = await TalkApi.getTalkList();
    notifyListeners();
  }
}