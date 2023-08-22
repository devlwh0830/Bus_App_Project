import 'package:flutter/material.dart';

void error_reports(context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("사용자 불편 신고하기"),
          ],
        ),
        //
        content: Container(
            height: 20,
            width: double.infinity,
            padding: EdgeInsets.only(left: 5,right: 5),
            child: Center(
              child: Text(
                "구현 예정",
                textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20),),
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