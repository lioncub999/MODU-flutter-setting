import 'package:flutter/material.dart';
import 'package:modu_flutter/apis/Auth/AuthApi.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var registerLginId;
  var registerNm;
  var registerEmail;
  var registerPw;
  var userGender;
  DateTime? userBirth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'UserId',
                  ),
                  onChanged: (value) {
                    setState(() {
                      registerLginId = value;
                    });
                  },
                ),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'UserNm',
                  ),
                  onChanged: (value) {
                    setState(() {
                      registerNm = value;
                    });
                  },
                ),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    setState(() {
                      registerEmail = value;
                    });
                  },
                ),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      registerPw = value;
                    });
                  },
                ),
              ),
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
              Text(userBirth != null?
                  userBirth.toString().split(" ")[0] :
                  "날짜 선택 안됨"
              ),
              ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),)
                        .then((selectedDate) {
                          setState(() {
                            userBirth = selectedDate;
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
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue)),
                      onPressed: () {
                        AuthApi.register({
                          "registerLginId" : registerLginId,
                          "registerPw" : registerPw,
                          "registerNm" : registerNm,
                          "registerEmail" : registerEmail,
                          "userGender" : userGender,
                          "userBirth" : userBirth.toString().split(" ")[0]
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        "회원 가입",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              )
            ],
          )
      ),
    );
  }
}
