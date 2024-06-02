import 'package:flutter/material.dart';
import 'package:modu_flutter/view/layout/appbar/appbarUI.dart';

class CustomNavigator extends StatelessWidget {
  const CustomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUI(
        title: "글작성임",
      ),
      body: Container(child: Text("네비게이터 바디임")),
    );
  }
}
