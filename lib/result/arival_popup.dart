import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

var result;
busArrivalInfo2(stationId,routeId,number) async { // 버스 도착 정보
  var data = {};
  var datas = [];
  var result = await http.get(
      Uri.parse('http://openapi.gbis.go.kr/ws/rest/busarrivalservice?serviceKey=1234567890&stationId=$stationId&routeId=$routeId&staOrder=$number'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var getXmlData = result.body; //XML 데이터 받기
    var Xml2JsonData = Xml2Json()..parse(getXmlData); // XML에서 JSON 형식으로 데이터 변환
    var jsonData = Xml2JsonData.toParker();
    data = jsonDecode(jsonData); //JSON 형식으로 디코딩
    data = data['response']['msgBody']; // 필터링
    try{
      datas = data['busArrivalItem'];
    }catch (e){
      datas.add(data['busArrivalItem']);
    }
    return datas; // 값 반환
  }
}

busType(a){
  if(a=="0"){
    return "일반";
  }else if(a=="1"){
    return "저상";
  }else{
    return "N/A";
  }
}

time(a){
  if(int.parse(a)<=5){
    return "잠시후";
  }else{
    return "${a}분 뒤";
  }
}

void FlutterDialog(context,lineName,stationId,busline,staOrder) async{
  try{
    result = await busArrivalInfo2(stationId,busline,staOrder);
  }catch(e){
    result = [{"plateNo1":"null","plateNo2":"null"}];
  }
  showDialog(
    context: context,
    //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context,setState){
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            //Dialog Main Title
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$lineName번 버스 도착 예정 정보"),
              ],
            ),
            //
            content: Container(
              height: 170,
              width: 500,
              child: Column(
                children: [
                  Container(
                      height: 60,
                      width: 500,
                      padding: EdgeInsets.only(left: 1,right: 1),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade700,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(result[0]['plateNo1'].toString() != "null")...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8,left: 10),
                                  child: Text(
                                    "${busType(result[0]['lowPlate1'])}",
                                    textAlign: TextAlign.center,style: TextStyle(color: busType(result[0]['lowPlate1'])=="저상"?Colors.cyanAccent:Colors.white,fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1,left: 10),
                                  child: Text(
                                    "차량번호 : ${result[0]['plateNo1'].toString().substring(5)}",
                                    textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8,right: 5),
                                  child: Text(
                                    "${time(result[0]['predictTime1'])} 도착",
                                    textAlign: TextAlign.center,style: TextStyle(color: Colors.cyanAccent,fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1,right: 5),
                                  child: Text(
                                    "${result[0]['locationNo1']}번째 전",
                                    textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 17),
                                  ),
                                )
                              ],
                            )
                          ]else...[
                            Container(
                              margin: EdgeInsets.only(left: 90),
                              child: Text(
                                "운행 정보 없음",
                                textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 17),
                              ),
                            )
                          ]
                        ],
                      )
                  ),
                  Container(
                      height: 60,
                      width: 500,
                      padding: EdgeInsets.only(left: 1,right: 1),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade700,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(result[0]['plateNo2'].toString() != "null")...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8,left: 10),
                                  child: Text(
                                    "${busType(result[0]['lowPlate2'])}",
                                    textAlign: TextAlign.center,style: TextStyle(color: busType(result[0]['lowPlate1'])=="저상"?Colors.cyanAccent:Colors.white,fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1,left: 10),
                                  child: Text(
                                    "차량번호 : ${result[0]['plateNo2'].toString().substring(5)}",
                                    textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 17),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 8,right: 5),
                                  child: Text(
                                    "${result[0]['predictTime2']}분 뒤 도착",
                                    textAlign: TextAlign.center,style: TextStyle(color: Colors.cyanAccent,fontSize: 20),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 1,right: 5),
                                  child: Text(
                                    "${result[0]['locationNo2']}번째 전",
                                    textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 17),
                                  ),
                                )
                              ],
                            )
                          ]else...[
                            Container(
                              margin: EdgeInsets.only(left: 90),
                              child: Text(
                                "운행 정보 없음",
                                textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 17),
                              ),
                            )
                          ]
                        ],
                      )
                  ),
                  Text(
                    "🚨 기상 또는 교통상황에 따라 정확하지 않을 수 있습니다.",
                    textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 11),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async{
                  result = await busArrivalInfo2(stationId,busline,staOrder);
                  setState(() {
                    result = result;
                  });
                },
                child: Text("새로고침"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("닫기"),
              )
            ],
          );
        }
      );
    },
  );
}