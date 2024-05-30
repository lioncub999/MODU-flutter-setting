import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key, this.fromGetData, this.fromPostData});
  final fromGetData;
  final fromPostData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (c, i) {
            return Column(
              children: [
                Text("getData : ${fromGetData}"),
                Text("postData : ${fromPostData}")
              ],
            );
          }),
    );
  }
}
