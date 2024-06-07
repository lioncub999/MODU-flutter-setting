import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modu_flutter/apis/HelloApi.dart';
import 'package:modu_flutter/view/customWidget/navigator.dart';

class AppBarUI extends StatelessWidget implements PreferredSizeWidget {
  const AppBarUI(
      {super.key,
      required this.title,
      this.bottom,
      this.setFromGetData,
      this.setFromPostData});

  final String title;
  final PreferredSizeWidget? bottom;
  final setFromGetData;
  final setFromPostData;

  @override
  Widget build(BuildContext context) {
    void getData() async {
      try {
        final response = await HelloApi.getHello();
        final data = response.body;
        setFromGetData(data);
        print(data);
      } catch (e) {
        print(e.toString());
      }
    }

    void postData() async {
      try {
        final response = await HelloApi.postHello({'loginId': 'asd', 'loginPw': 'asd'});
        final data = jsonDecode(response.body);
        setFromPostData(data);
        print(data);
      } catch (e) {
        print(e.toString());
      }
    }

    return AppBar(
      backgroundColor: Colors.blue,
      title: Text(title),
      actions: [
        Text("임시"),
        IconButton(
            onPressed: () {
              // getData();
              postData();
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
