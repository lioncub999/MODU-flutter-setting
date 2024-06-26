import 'package:flutter/material.dart';
import 'package:modu_flutter/apis/ApiResponse.dart';
import 'package:modu_flutter/apis/Auth/AuthApi.dart';
import 'package:modu_flutter/apis/Auth/AuthModel.dart';
import 'package:provider/provider.dart';

import '../../provider/MainStore.dart';
import '../../ui/common/Inputs.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var userLoginId;
  var userNm;
  var userEmail;
  var userPw;
  var userGender;
  DateTime? userBirthday;

  Register() async {
    try {
      RegisterData registerData = new RegisterData();
      registerData.userLoginId = userLoginId;
      registerData.userPw = userPw;
      registerData.userNm = userNm;
      registerData.userEmail = userEmail;
      registerData.userGender = userGender;
      registerData.userBirthday = userBirthday.toString().split(" ")[0];

      final ApiResponse apiResponse = await AuthApi.register(registerData.toJson());

      if (apiResponse.ok) {
        Navigator.pop(context);
      } else {
        print("오류");
      }

    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UIInput(
                  labelText: "UserId",
                  obscureText: false,
                  onChangedFunc: (value) {
                    setState(() {
                      userLoginId = value;
                    });
                  }),
              UIInput(
                  labelText: "UserNm",
                  obscureText: false,
                  onChangedFunc: (value) {
                    setState(() {
                      userNm = value;
                    });
                  }),
              UIInput(
                  labelText: "Email",
                  obscureText: false,
                  onChangedFunc: (value) {
                    setState(() {
                      userEmail = value;
                    });
                  }),
              UIInput(
                  labelText: "Password",
                  obscureText: true,
                  onChangedFunc: (value) {
                    setState(() {
                      userPw = value;
                    });
                  }),
              ListTile(
                title: Text("남자"),
                leading: Radio(
                  value: "M",
                  groupValue: userGender,
                  onChanged: (value) {
                    setState(() {
                      userGender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("여자"),
                leading: Radio(
                  value: "W",
                  groupValue: userGender,
                  onChanged: (value) {
                    setState(() {
                      userGender = value;
                    });
                  },
                ),
              ),
              Text(userBirthday != null ? userBirthday.toString().split(" ")[0] : "날짜 선택 안됨"),
              ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    ).then((selectedDate) {
                      setState(() {
                        userBirthday = selectedDate;
                      });
                    });
                  },
                  child: Text("날짜 선택")),
              Container(
                width: 300,
                child: Container(
                  width: 300,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                      onPressed: () {
                        Register();
                      },
                      child: Text(
                        "회원 가입",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
