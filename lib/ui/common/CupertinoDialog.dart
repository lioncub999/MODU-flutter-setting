import 'package:flutter/cupertino.dart';

// TODO: 공통 아이폰 알림
class CupertinoDialog {
  static showAlert(context, String title, String cont, String buttonText) async {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title : Text(title),
            content: Text(cont),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(buttonText),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}