import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modu_flutter/apis/Talk/TalkModel.dart';
import 'package:modu_flutter/utils/formatter/datetime_utils.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../provider/TalkStore.dart';
import '../../common/UserProfilePage.dart';

class TalkListWz extends StatelessWidget {
  const TalkListWz({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<TalkStore>().talkList.length,
      itemBuilder: (c, i) {
        Talk talk = context.watch<TalkStore>().talkList[i];
        var creDtm = DateTime.parse(talk.creDtm ?? '');

        return SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
            ),
            child: Row(
              children: [
                // TODO: Navigator - UserProfilePage
                Expanded(
                  flex: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => UserProfilePage(userId: talk.userId ?? '')),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            talk.talkCont ?? '',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Icon(
                                talk.userGender == 'M' ? Icons.man : Icons.woman,
                                color: talk.userGender == 'M' ? Colors.blue : Colors.pink,
                              ),
                              Text(
                                talk.userNm ?? '',
                                style: TextStyle(
                                    color: talk.userGender == 'M' ? Colors.blue : Colors.pink),
                              ),
                              FutureBuilder<String>(
                                future: DateTimeUtils.timeAgo(creDtm),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Text("Loading...");
                                  } else if (snapshot.hasError) {
                                    return Text("Error");
                                  } else {
                                    return Text(" | " + snapshot.data!);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //TODO: Talk Image
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Image.network(
                      talk.imgWebPath ?? '',
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
                      },
                    ),
                  ),
                ),

                // TODO: Start Talk
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.insert_comment,
                        size: 40,
                        color: talk.userGender == "M" ? Colors.blue : Colors.pink,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
