import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' as foundation;
import '../apis/api.dart';
import '../view/popup.dart';
import 'kakaomap.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  var lng;
  var lat;
  var result = [];
  var a = 0;
  var statuss = false;

  void FlutterDialogs(context) {
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
              Text("귀하의 위치 정보가 필요 합니다.",style: TextStyle(fontSize: 16),),
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
                  "GPS 기반으로 정류장을 조회 합니다.\n귀하의 위치 정보는 외부로\n저장 또는 유출되지 않습니다.",
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 15),),
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
                    Navigator.pop(context);
                    setState(() {
                      result = [{"stationName":"위치 권한을 허용해 주세요."}];
                    });
                  },
                  child: Text("취소"),
                ),
                TextButton(
                  onPressed: ()async{
                    Navigator.pop(context);
                    getLocation();
                  },
                  child: Text("계속"),
                )
              ],
            )
          ],
        );
      },
    );
  }

  void getLocation() async{
    PermissionStatus status = await Permission.location.request();
    // 결과 확인
    if(!status.isGranted) { // 허용이 안된 경우
      // ignore: use_build_context_synchronously
      FlutterDialog(context);
    } else{
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var results = await gpsStationSearch(position.longitude, position.latitude);
      setState((){
        lng = position.longitude;
        lat = position.latitude;
        result = results;
      });
    }
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async{
      if(!await Permission.location.isGranted){
        FlutterDialogs(context);
      }else{
        getLocation();
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(221, 236, 202, 1),
      child: Container(
        padding: EdgeInsets.only(top: 15,left: 10,right: 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.zero,top: Radius.circular(35)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text("귀하의 주변에 있는 버스 정류장 입니다.",style: TextStyle(fontSize: 20),),
            ),
            Expanded(
              child: FutureBuilder(
                future: _fetch1(),
                builder: (context, snapshot) {
                  if (snapshot.hasData == false) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else{
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: result.length,
                      itemBuilder: (c, i){
                        return TextButton(
                          onPressed: (){
                            if(result[i]['stationName'] != "위치 권한을 허용해 주세요."){
                              setState(() {
                                KakaoDialog(c,result[i]);
                              });
                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.only(top: 10),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.directions_bus,size: 30,color: Colors.green,),
                                  SizedBox(width: 20,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${result[i]['stationName']}",
                                          style: TextStyle(color: Colors.black,fontSize: 20),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${result[i]['distance']??"0"}m |${result[i]['mobileNo']??"위치 확인불가"} (${result[i]['regionName']??"위치확인불가"})",
                                          style: TextStyle(color: Colors.black,fontSize: 13),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        )
      ),
    );
  }
  Future<String> _fetch1() async {
    await Future.delayed(Duration(seconds: 2));
    return "call";
  }
}
