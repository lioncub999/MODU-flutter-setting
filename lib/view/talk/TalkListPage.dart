import 'package:flutter/material.dart';
import 'package:modu_flutter/main.dart';
import 'package:modu_flutter/view/talk/TalkAppbarWz.dart';
import 'package:modu_flutter/view/talk/TalkListWz.dart';
import 'package:provider/provider.dart';

class TalkListPage extends StatefulWidget {
  const TalkListPage({super.key});

  @override
  State<TalkListPage> createState() => _MainpageState();
}

class _MainpageState extends State<TalkListPage> {
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
          title: "토크",
        ),
        body: TalkListWz()
      );
    } else {
      return Text("로딩중");
    }
  }
}
