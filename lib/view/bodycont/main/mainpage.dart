import 'package:flutter/material.dart';
import 'package:modu_flutter/view/customWidget/listview.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key, this.fromGetData, this.fromPostData});
  final fromGetData;
  final fromPostData;

  @override
  Widget build(BuildContext context) {
    return CustomListView();
  }
}
