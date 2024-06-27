// TODO: TalkStore (Provider)
import 'package:flutter/cupertino.dart';
import 'package:modu_flutter/apis/Talk/TalkModel.dart';

import '../apis/Talk/TalkApi.dart';

class TalkStore extends ChangeNotifier {
  List<Talk> talkList = [];
  getTalkList() async {
    talkList = await TalkApi.getTalkList();
    notifyListeners();
  }
}