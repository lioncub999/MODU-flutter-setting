import 'package:flutter/material.dart';
import 'package:modu_flutter/apis/TalkApi.dart';
import 'package:modu_flutter/main.dart';
import 'package:provider/provider.dart';

class TalkWrite extends StatefulWidget {
  const TalkWrite({super.key});

  @override
  State<TalkWrite> createState() => _BoardWriteState();
}

class _BoardWriteState extends State<TalkWrite> {
  var talkCont;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Icon(Icons.edit),
        actions: [IconButton(onPressed: () async {
          await TalkApi.insertTalk({"talkCont" : talkCont});
          await context.read<MainStore>().getTalkList();
          Navigator.pop(context);
        }, icon: Icon(Icons.check))],
      ),
      body: Container(
        child: Column(
          children: [
            Card(
                color: Colors.grey,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 8, //or null
                    decoration:
                        InputDecoration.collapsed(hintText: "내용 입력"),
                    onChanged: (value) {
                      setState(() {
                        talkCont = value;
                      });
                    },
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: () {},
                    child: Text("전체삭제")),
                Text("0/200")
              ],
            ),
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
