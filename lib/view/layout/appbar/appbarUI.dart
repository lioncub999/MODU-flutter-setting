import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modu_flutter/apis/HelloApi.dart';
import 'package:modu_flutter/main.dart';
import 'package:modu_flutter/view/customWidget/navigator.dart';
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
      title: Text(title),
      actions: [
        Text("임시"),
        IconButton(
            onPressed: () {
              logout();
              context.read<MainStore>().setIsLogin(1);
            },
            icon: Icon(Icons.star_border)),
        GestureDetector(
          child: Icon(Icons.add_box_outlined),
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => CustomNavigator()),
            );
          },
        ),
      ],
    );
  }

  // TODO: kToolbarHeight : appbar 높이(int)
  @override
  Size get preferredSize => Size.fromHeight(bottom == null
      ? kToolbarHeight
      : kToolbarHeight + bottom!.preferredSize.height);
}
