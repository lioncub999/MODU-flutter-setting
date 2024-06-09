import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modu_flutter/main.dart';
import 'package:modu_flutter/view/bodycont/main/talkwrite.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarUI extends StatelessWidget implements PreferredSizeWidget {
  const AppBarUI({
    super.key,
    required this.title,
    this.bottom,
  });

  final String title;
  final PreferredSizeWidget? bottom;

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwtToken');
    prefs.remove('loginId');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      actions: [
        IconButton(
            onPressed: () {
              logout();
              context.read<MainStore>().setIsLogin(1);
            },
            icon: Icon(Icons.star_border)),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => TalkWrite()),
              );
            },
            icon: Icon(Icons.edit))
      ],
    );
  }

  // TODO: kToolbarHeight : appbar 높이(int)
  @override
  Size get preferredSize => Size.fromHeight(bottom == null
      ? kToolbarHeight
      : kToolbarHeight + bottom!.preferredSize.height);
}
