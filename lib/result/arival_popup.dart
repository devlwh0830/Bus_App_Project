import 'package:flutter/material.dart';

void FlutterDialog(context,stationName) {
  showDialog(
    context: context,
    //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        //Dialog Main Title
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("$stationName번 버스 도착 예정 정보"),
          ],
        ),
        //
        content: Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.only(left: 5,right: 5),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "작업 전\n구현 예정",
                textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20),),
            )
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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