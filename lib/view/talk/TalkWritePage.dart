import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modu_flutter/apis/TalkApi.dart';
import 'package:modu_flutter/main.dart';
import 'package:provider/provider.dart';

import '../../provider/TalkStore.dart';

class TalkWritePage extends StatefulWidget {
  const TalkWritePage({super.key});

  @override
  State<TalkWritePage> createState() => _BoardWriteState();
}

class _BoardWriteState extends State<TalkWritePage> {
  var talkCont;

  insetTalk() async {
    if (talkCont == null || talkCont == '') {
      final snackBar = SnackBar(
        content: Text('토크 내용을 작성해주세요!'),
        action: SnackBarAction(
          label: '확인',
          onPressed: () {
            // 확인 버튼 클릭시 실행할거
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await TalkApi.insertTalk({"talkCont": talkCont});
      await context.read<TalkStore>().getTalkList();
      Navigator.pop(context);
    }
  }

  // TODO: talk TextField 컨트롤러
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Icon(Icons.edit),
        actions: [
          IconButton(
              onPressed: () async {
                insetTalk(); // 토크 생성
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            // TODO: 토크 입력 TEXTFIELD
            Card(
                color: Colors.grey,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    maxLength: 200,
                    maxLines: 8,
                    // or null
                    decoration: InputDecoration.collapsed(
                      hintText: "내용 입력",
                    ),
                    inputFormatters: [
                      _LengthLimitingTextInputFormatterFixed(200),
                    ],
                    onChanged: (value) {
                      setState(() {
                        talkCont = value;
                      });
                    },
                  ),
                )),

            // TODO: 토크 내용 전체 삭제 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        talkCont = "";
                      });
                    },
                    child: Text("전체삭제")),
              ],
            ),

            // TODO: 제제 대상 박스
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.black,
                width: 2,
              )),
              child: Text("<제제대상> 어쩌구 저쩌구"),
            )
          ],
        ),
      ),
    );
  }
}

// TODO: 200자 넘었을때 한글까지 막음
class _LengthLimitingTextInputFormatterFixed extends TextInputFormatter {
  final int maxLength;

  _LengthLimitingTextInputFormatterFixed(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.characters.length > maxLength) {
      return oldValue;
    }
    return newValue;
  }
}
