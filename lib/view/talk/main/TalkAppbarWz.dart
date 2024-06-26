import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modu_flutter/function/auth/AuthFnc.dart';
import 'package:modu_flutter/main.dart';
import 'package:modu_flutter/view/talk/write/TalkWritePage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/MainStore.dart';

class TalkAppbarWz extends StatelessWidget implements PreferredSizeWidget {
  const TalkAppbarWz({
    super.key,
    required this.title,
    required this.backgroundColor,
    this.bottom,
  });

  final String title;
  final Color backgroundColor;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(

      backgroundColor: backgroundColor,
      actions: [
        // TODO: AppbarButton - logout
        IconButton(
            onPressed: () {
              AuthFnc.logout(context);
            },
            icon: Icon(Icons.star_border)),

        // TODO: AppbarButton - Navigator - TalkWritePage
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => TalkWritePage()),
              );
            },
            icon: Icon(Icons.edit))
      ],
    );
  }

  // TODO: kToolbarHeight : appbar 높이(int) (PreferredSizeWidget 필수)
  @override
  Size get preferredSize => Size.fromHeight(bottom == null ? kToolbarHeight : kToolbarHeight + bottom!.preferredSize.height);
}
