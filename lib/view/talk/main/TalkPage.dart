import 'package:flutter/material.dart';
import 'package:modu_flutter/main.dart';
import 'package:modu_flutter/view/talk/main/TalkAppbarWz.dart';
import 'package:modu_flutter/view/talk/main/TalkListWz.dart';
import 'package:provider/provider.dart';

import '../../../provider/TalkStore.dart';

class TalkPage extends StatefulWidget {
  const TalkPage({super.key});

  @override
  State<TalkPage> createState() => _MainpageState();
}

class _MainpageState extends State<TalkPage> {
  @override
  void initState() {
    super.initState();
    context.read<TalkStore>().getTalkList();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<TalkStore>().talkList != null) {
      return Scaffold(
        appBar: TalkAppbarWz(
          title: "토크 메인",
          backgroundColor : Colors.blue,
        ),
        body: TalkListWz()
      );
    } else {
      // TODO: 토크 리스트 로딩중
      return Center(
        child: Text("로딩중"),
      );
    }
  }
}
