import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modu_flutter/apis/Talk/TalkApi.dart';
import 'package:modu_flutter/apis/Talk/TalkModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../provider/TalkStore.dart';

class TalkWritePage extends StatefulWidget {
  const TalkWritePage({super.key});

  @override
  State<TalkWritePage> createState() => _BoardWriteState();
}

class _BoardWriteState extends State<TalkWritePage> {
  XFile? _image; // 이미지를 담을 변수 선언
  final ImagePicker _picker = ImagePicker();
  setXfile(image) {
    setState(() {
      _image = image;
    });
  }

  Future<void> _requestPermission() async {
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      print("사진첩 접근 권한 허용됨");
      _pickImage(); // 권한이 허용된 경우 이미지 선택 함수 호출
    } else if (status.isDenied) {
      print("사진첩 접근 권한 거부됨");
    } else if (status.isPermanentlyDenied) {
      print("사진첩 접근 권한 영구적으로 거부됨");
      _showPermissionDialog();
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // 파일을 선택한 경우
      setState(() {
        _image = pickedFile; // 선택된 파일을 상태로 저장
      });
      File file = File(pickedFile.path);
      int fileSize = await file.length();
      print(fileSize);
    } else {
      print('이미지 선택이 취소되었습니다.');
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: Text('권한 필요'),
            content: Text('사진첩 접근 권한이 필요합니다. 설정에서 권한을 허용해주세요.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
                child: Text('설정으로 이동'),
              ),
            ],
          ),
    );
  }

  var talkCont;

  insetTalk() async {
    if (talkCont == null || talkCont == '') {
      final snackBar = SnackBar(
        content: Text('토크 내용을 작성해주세요!'),
        action: SnackBarAction(
          label: '확인',
          onPressed: () {
            // 확인 버튼 클릭시 실행할 것
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Talk talkInput = Talk();
      talkInput.talkCont = talkCont;

      await TalkApi.insertTalk(talkInput.toJson());
      await context.read<TalkStore>().getTalkList();

      if (_image != null) {
        // 선택된 이미지 파일을 읽기
        File file = File(_image!.path);

        // http PUT 요청을 보낼 준비
        var request = http.Request('PUT', Uri.parse('https://modu-s3-dev.s3.ap-northeast-2.amazonaws.com/2024/06/28/1719554362891_ttttPR-240628L5222094743?x-amz-acl=public-read&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240628T055922Z&X-Amz-SignedHeaders=host&X-Amz-Expires=599&X-Amz-Credential=AKIAYS2NWXJ5VGWUPTBG%2F20240628%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=6ea05e4e1be54441674c9741e9c57640ae674fbd16d4d841c008e8adc5946bf8'));
        request.headers['Content-Length'] = file.lengthSync().toString();
        request.headers['Content-Type'] = 'image/jpeg'; // 파일 유형에 맞게 설정

        // 파일 내용을 요청에 추가
        request.bodyBytes = await file.readAsBytes();

        // 요청 보내기
        var response = await request.send();

        // 응답 처리
        if (response.statusCode == 200) {
          print('파일 업로드 성공');
        } else {
          print('파일 업로드 실패: ${response.reasonPhrase}');
        }
      } else {
        print('이미지 선택이 취소되었습니다.');
      }
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
          // TODO: 토크 등록
          IconButton(
              onPressed: () async {
                await insetTalk();
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
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

              _image == null
                  ?
              // TODO: 사진 등록
              Container(
                child: IconButton(
                  icon: Icon(Icons.add_to_photos),
                  onPressed: () {
                    _requestPermission();
                  },
                  iconSize: 70,
                ),
              )
                  : Column(children: [
                Container(
                  width: 300,
                  height: 300,
                  child:
                  Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
                ),
                Container(
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setXfile(null);
                      },
                      iconSize: 70,
                    ),
                )
              ]),

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
              ),
            ],
          ),
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
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    if (newValue.text.characters.length > maxLength) {
      return oldValue;
    }
    return newValue;
  }
}
