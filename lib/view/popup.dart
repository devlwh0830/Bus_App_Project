import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void FlutterDialog(context) {
  showDialog(
    context: context,
    //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        //Dialog Main Title
        title: Column(
          children: <Widget>[
            Text("위치 권한을 먼저 허용해 주세요.",style: TextStyle(fontSize: 20),),
          ],
        ),
        //
        content: Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "위치 권한을 제공 받지 못할 경우 주변 정류장\n검색 서비스를 사용할 수 없습니다.",
                textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            )
        ),
        titlePadding: EdgeInsets.only(left: 15,bottom: 15,top: 15,right: 50),
        contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 5),
        actionsPadding: EdgeInsets.only(right: 10,bottom: 5),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: (){
                  openAppSettings();
                },
                child: Text("권한설정"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("닫기"),
              )
            ],
          )
        ],
      );
    },
  );
}