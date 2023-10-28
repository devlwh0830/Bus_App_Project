import 'package:flutter/material.dart';

void money_info(context) {
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
            Text("경기도 버스 요금표"),
          ],
        ),
        //
        content: Image.network("https://media.discordapp.net/attachments/905797523363483659/1167686088429670460/image.png?ex=654f076a&is=653c926a&hm=614a3c3f6c25cfa081ed1bec9c6547d1ca472364bc28e4f827229ce34c58dad8&=&width=1919&height=493"),
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