import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modu_flutter/main.dart';
import 'package:provider/provider.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

// TODO: creDtm 과 현재시간 비교하여 시간 찍기
String timeAgo(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inMinutes < 1) {
    return '방금 전';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}분 전';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}시간 전';
  } else if (difference.inDays < 7) {
    return '${difference.inDays}일 전';
  } else {
    return DateFormat('yyyy년 MM월 dd일').format(date); // 1주 이상은 날짜 형식으로 반환
  }
}

class _MainpageState extends State<Mainpage> {
  @override
  void initState() {
    super.initState();
    context.read<MainStore>().getTalkList();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<MainStore>().talkList != null) {
      return ListView.builder(
        itemCount: context.watch<MainStore>().talkList.length,
        itemBuilder: (c, i) {
          return SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1))),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.watch<MainStore>().talkList[i]["talkCont"],
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                context.watch<MainStore>().talkList[i]
                                            ["userGender"] ==
                                        'M'
                                    ? Icons.man
                                    : Icons.woman,
                                color: context.watch<MainStore>().talkList[i]
                                            ["userGender"] ==
                                        'M'
                                    ? Colors.blue
                                    : Colors.pink,
                              ),
                              Text(
                                context.watch<MainStore>().talkList[i]
                                    ["userNm"],
                                style: TextStyle(
                                    color: context
                                                .watch<MainStore>()
                                                .talkList[i]["userGender"] ==
                                            'M'
                                        ? Colors.blue
                                        : Colors.pink),
                              ),
                              Text("|" +
                                  timeAgo(DateTime.parse(context
                                      .watch<MainStore>()
                                      .talkList[i]["creDtm"]))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child:
                      Image.network(
                        'https://modu-s3-dev.s3.ap-northeast-2.amazonaws.com/2024/06/03/1717395093529_%ED%8C%8C%EC%9D%BC%EC%9D%B4%EB%A6%84PR-240603L7466749476',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          return Center(
                            child: Text('Failed to load image'),
                          );
                        })
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: IconButton(
                          onPressed: () {

                          },
                          icon: Icon(
                            Icons.insert_comment,
                            size: 40,
                            color: context.watch<MainStore>().talkList[i]["userGender"] == "M" ?
                            Colors.blue : Colors.pink
                            ,),
                        ),
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Text("로딩중");
    }
  }
}
