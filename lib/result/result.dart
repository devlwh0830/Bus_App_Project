import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:busapp/apis/api.dart';
import 'package:busapp/result/arival_popup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'busline_result.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:shared_preferences/shared_preferences.dart';

class Result_view extends StatefulWidget {
  Result_view({super.key, this.displayId, this.station_name, this.station_id,this.station_info,this.star_check});
  final displayId;
  final station_name;
  final station_id;
  final station_info;
  final star_check;

  @override
  State<Result_view> createState() => _Result_viewState();
}

class _Result_viewState extends State<Result_view> {

  late Timer timer;
  var colors;
  var storage;
  var result;
  var lineName;
  var datas;
  var stars  = Icon(Icons.star_border,color: Colors.yellow,size: 30,);
  Map<String,String> data = {};
  Map<String,dynamic> arrival = {};

  flutterToast(String a) {
    Fluttertoast.showToast(
        msg: "이 버스는 ${a} 입니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 15.0
    );
  }

  manyfind(String a) {
    Fluttertoast.showToast(
        msg: "즐겨찾기가 $a 되었습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 15.0
    );
  }

  getColor(String color){
    if(color == "직행좌석형시내버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139884238708146236/green_bus.png?width=460&height=460");
    }else if(color == "좌석형시내버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139893877604618260/green_bus.png?width=460&height=460");
    }else if(color == "일반형시내버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432");
    }else if(color == "광역급행형시내버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139884238708146236/green_bus.png?width=460&height=460");
    }else if(color == "마을버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139884388683886623/green_bus.png?width=460&height=460");
    }else if(color == "따복형 시내버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432");
    }else if(color == "직행좌석형농어촌버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139884238708146236/green_bus.png?width=460&height=460");
    }else if(color == "좌석형농어촌버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432");
    }else if(color == "일반형농어촌버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432");
    }else if(color == "일반형시외버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432");
    }else if(color == "리무진형 공항버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139894619291799562/green_bus.png?width=460&height=460");
    }else if(color == "좌석형 공항버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139894619291799562/green_bus.png?width=460&height=460");
    }else{
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139894619291799562/green_bus.png?width=460&height=460");
    }
    return colors;
  }

  time(a,b,c){
    if(a != null){
      if(int.parse(a)<=2){
        if(c!="-1" && c!=null){
          return "잠시 후 도착 ($b번째 전)($c석)";
        }else{
          return "잠시 후 도착 ($b번째 전)";
        }
      }else{
        if(c!="-1" && c!=null){
          return "$a분 ($b번째 전)($c석)";
        } else{
          return "$a분 ($b번째 전)";
        }
      }
    }else{
      return "도착정보없음";
    }
  }

  busType(a){
    if(a['plateNo1'] != null){
      if(a['lowPlate1'] == "0"){
        return "일반 ${a['plateNo1'].toString().substring(a['plateNo1'].toString().length-4,a['plateNo1'].toString().length)}";
      }else{
        return "저상 ${a['plateNo1'].toString().substring(a['plateNo1'].toString().length-4,a['plateNo1'].toString().length)}";
      }
    }else{
      return "  ";
    }
  }

  busType1(a){
    if(a['plateNo2'] != null){
      if(a['lowPlate2'] == "0"){
        return "일반 ${a['plateNo2'].toString().substring(a['plateNo2'].toString().length-4,a['plateNo2'].toString().length)}";
      }else{
        return "저상 ${a['plateNo2'].toString().substring(a['plateNo2'].toString().length-4,a['plateNo2'].toString().length)}";
      }
    }else{
      return "  ";
    }
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    if(widget.star_check){
      stars  = Icon(Icons.star,color: Colors.yellow,size: 30,);
    }else{
      stars  = Icon(Icons.star_border,color: Colors.yellow,size: 30,);
    }

    timer = Timer.periodic(Duration(seconds: 30), (Timer timer) {
      setState(() {
        _fetch1(); // 30초마다 데이터 다시 가져오기
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // 화면이 나가면 타이머 중지
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.blueAccent,
          title: Text("정류장 검색 결과"),
          actions: [
            IconButton(
                onPressed: ()async{
                  var storage = await SharedPreferences.getInstance();
                  var result = storage.getStringList('정차${widget.station_id}');
                  if(result == null){
                    print(widget.station_info);
                    storage.setStringList('정차${widget.station_id}', [widget.station_name,widget.station_id,widget.displayId]);
                    manyfind("설정");
                    setState(() {
                      stars = Icon(Icons.star,color: Colors.yellow,size: 30,);
                    });
                  }else{
                    storage.remove('정차${widget.station_id}');
                    manyfind("해제");
                    setState(() {
                      stars = Icon(Icons.star_border,color: Colors.yellow,size: 30,);
                    });
                  }
                },
                icon: stars
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                margin: EdgeInsets.only(bottom: 5),
                height: 100,
                color: Colors.blueAccent,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text("${widget.station_name}", style: TextStyle(
                        fontSize: 20, color: Colors.white)),
                    Text("", style: TextStyle(
                        fontSize: 5, color: Colors.white)),
                    Text("${widget.station_id}", style: TextStyle(
                        fontSize: 20, color: Colors.white))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: foundation.defaultTargetPlatform == foundation.TargetPlatform.iOS ? 710 : MediaQuery.of(context).size.height - 210,
                child: FutureBuilder(
                  future: _fetch1(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }else{
                      return ListView.builder(
                          itemCount: widget.station_info.length,
                          itemBuilder: (c, i) {
                            return TextButton(
                              onPressed: ()async{
                                var storage = await SharedPreferences.getInstance();
                                var results = storage.getStringList('노선${widget.station_info[i]['routeId']}');
                                var star_check = results == null ? false : true;
                                var result;
                                var result2;
                                var result3;
                                var line_info;
                                try{
                                  line_info = await busRouteName(widget.station_info[i]['routeId']);
                                  result = await busStationList(widget.station_info[i]['routeId']);
                                  result2 = await turnBus(widget.station_info[i]['routeId']);
                                }catch(e){
                                  result = [{'routeId':'000000','routeName':"정보를 찾을 수 없음","routeTypeName":"정보가 없습니다."}];
                                }

                                try{
                                  result3 = await busLocationList(widget.station_info[i]['routeId']);
                                }catch(e){
                                  result3 = null;
                                }
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (_) => BusLine_Result_view(stationlist:result,lineName:widget.station_info[i]['routeName'],turnYn:result2,routeId:widget.station_info[i]['routeId'],seachroute:true,staOrder:widget.station_info[i]['staOrder'],busposition: result3,routeTypeName: widget.station_info[i]['routeTypeName'].toString(),regionName:widget.station_info[i]['regionName'],star_check:star_check,line_info:line_info)));
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  margin: EdgeInsets.fromLTRB(
                                      10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(15),
                                          top: Radius.circular(15)),
                                      color: Colors.white,
                                      boxShadow:[
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.7),
                                          blurRadius: 1.0,
                                          spreadRadius: 0.0,
                                          offset: const Offset(0,5),
                                        )
                                      ]
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 30),
                                            height: 70,
                                            child: InkWell(
                                              child: getColor(widget.station_info[i]['routeTypeName'].toString()),
                                              onTap: (){
                                                flutterToast(widget.station_info[i]['routeTypeName'].toString());
                                              },
                                            ),
                                          ),
                                          Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.only(right: 10),
                                                      width: 200,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "",
                                                            style: TextStyle(color: Colors.black, fontSize: 2),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            "${widget.station_info[i]['routeName']}번",
                                                            style: TextStyle(color: Colors.black, fontSize: 20),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            "${data['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}']}방면",
                                                            style: TextStyle(color: Colors.black, fontSize: 15),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      )
                                                  )
                                                ],
                                              )
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15,right: 15),
                                        height: 0.5,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                                        width: double.infinity,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              busType(arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]),
                                              style: TextStyle(
                                                color: busType(arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]).toString().substring(0,2) == "저상" ?  Colors.blue : Colors.black,
                                                fontSize: 15
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 10,right: 10),
                                              alignment: Alignment.centerRight,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: time(arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['predictTime1'],arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['locationNo1'],arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['remainSeatCnt1']) == "도착정보없음" ?Colors.grey.shade300 : Colors.blue.shade100,
                                              ),
                                              child: Text(
                                                time(arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['predictTime1'],arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['locationNo1'],arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['remainSeatCnt1']),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15,right: 15),
                                        height: 0.5,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 15,right: 15,top: 5),
                                        width: double.infinity,
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              busType1(arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]),
                                              style: TextStyle(
                                                  color: busType1(arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]).toString().substring(0,2) == "저상" ?  Colors.blue : Colors.black,
                                                  fontSize: 15
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 10,right: 10),
                                              alignment: Alignment.centerRight,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: time(arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['predictTime2'],arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['locationNo2'],arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['remainSeatCnt2']) == "도착정보없음" ?Colors.grey.shade300 : Colors.blue.shade100,
                                              ),
                                              child: Text(
                                                time(arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['predictTime2'],arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['locationNo2'],arrival['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}'][0][0]['remainSeatCnt2']),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            );
                          }
                      );
                    }
                  },
                )
              ),
            ]
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          widget.station_info.forEach((i) async{
            var c;
            try{
              c = await busArrivalInfo2(widget.displayId,i['routeId'],i['staOrder']);
            }catch(e){
              c = [{"flag": null, "locationNo1": null, "locationNo2": null, "lowPlate1": null, "lowPlate2": null, "plateNo1": null, "plateNo2": null, "predictTime1": null, "predictTime2": null, "remainSeatCnt1": null, "remainSeatCnt2": null, "routeId": null, "staOrder": null, "stationId": null}];
            }
            setState(() {
              arrival.update(i['routeId'].toString() + i['staOrder'].toString(), (value) => [c]);
            });
          });
        },
        child: Icon(Icons.refresh_sharp,size: 40,),
      ),
    );
  }
  Future<String> _fetch1() async {
    widget.station_info.forEach((i) async{
      var c;
      var a = await busRouteName(i['routeId']);
      var b = await turnBus(i['routeId']);
      if(int.parse(i['staOrder'])<=b){
        data.addAll(
            {"${i['routeId']}${i['staOrder']}": "${a['endStationName']}"});
      }else{
        data.addAll(
            {"${i['routeId']}${i['staOrder']}": "${a['startStationName']}"});
      }
      try{
        c = await busArrivalInfo2(widget.displayId,i['routeId'],i['staOrder']);
      }catch(e){
        c = [{"flag": null, "locationNo1": null, "locationNo2": null, "lowPlate1": null, "lowPlate2": null, "plateNo1": null, "plateNo2": null, "predictTime1": null, "predictTime2": null, "remainSeatCnt1": null, "remainSeatCnt2": null, "routeId": null, "staOrder": null, "stationId": null}];
      }
      arrival.addAll({"${i['routeId']}${i['staOrder']}": [c]});
    });
    await Future.delayed(Duration(seconds: 1));
    return 'Call Data';
  }
}