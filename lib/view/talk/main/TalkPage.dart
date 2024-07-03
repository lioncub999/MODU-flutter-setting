import 'package:flutter/material.dart';
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
  bool _isLoading = true;

  void _loadData() async {
    setState(() {
      _isLoading = true;
    });
    await context.read<TalkStore>().getTalkList();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TalkAppbarWz(
        title: "토크 메인",
        backgroundColor: Colors.blue,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TalkListWz(),
    );
  }
}
