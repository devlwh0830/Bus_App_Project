import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:permission_handler/permission_handler.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(221, 236, 202, 1),
      child: Container(
        padding: EdgeInsets.only(top: 15),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.zero,top: Radius.circular(35)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: 20,
              margin: EdgeInsets.only(bottom: 5),
              child: Text("귀하의 주변에 있는 버스 정류장 입니다.",style: TextStyle(fontSize: 20),),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 225,
              child: FutureBuilder(
                future: _fetch1(),
                builder: (context, snapshot) {
                  if (snapshot.hasData == false) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (c, i){
                        return TextButton(
                          onPressed: (){
                            setState(() {
                              KakaoDialog(c,result[i]);
                            });
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.only(top: 10),
                          ),
                          child: Container(
                              height: 60,
                              width: double.infinity,
                              margin:EdgeInsets.fromLTRB(10,0, 10, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                                color: Colors.blueGrey,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 20,right: 30),
                                    child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116527200972308560/bus-stop.png?width=432&height=432",scale: 10,),
                                  ),
                                  Container(
                                      child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(top: 10,right: 10),
                                            width: 250,
                                            child: Text(
                                              "${result[i]['stationName']}",
                                              style: TextStyle(color: Colors.white,fontSize: 20),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Text(
                                              "${result[i]['distance']}m |${result[i]['mobileNo']} (${result[i]['regionName']})",
                                              style: TextStyle(color: Colors.white,fontSize: 15),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ],
                              )
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        )
      ),
    );
  }
  Future<String> _fetch1() async {
    await Future.delayed(Duration(seconds: 1));
    return "call";
  }
}
