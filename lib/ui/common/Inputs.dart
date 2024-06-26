import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// TODO: 공통 버튼
class UIButton extends StatelessWidget {
  const UIButton({super.key, required this.height, required this.color, required this.onPressedFunc, required this.buttonText});

  final double height;
  final Color color;
  final VoidCallback onPressedFunc;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: EdgeInsets.only(bottom: 10),
      child: TextButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
          onPressed: onPressedFunc,
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}

// TODO: 공통 텍스트 필드
class UIInput extends StatelessWidget {
  const UIInput({super.key, required this.labelText, required this.obscureText, required this.onChangedFunc});

  final String labelText;
  final bool obscureText;
  final ValueChanged<String> onChangedFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText
        ),
        onChanged: onChangedFunc,
      ),
    );
  }
}

