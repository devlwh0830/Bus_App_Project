import 'package:busapp/view/kakaomap.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:busapp/apis/api.dart';
import 'search.dart';
import 'popup.dart';

class Homes extends StatefulWidget {
  const Homes({super.key});

  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> {

  void getLocation() async{
    PermissionStatus status = await Permission.location.request();
    // 결과 확인
    if(!status.isGranted) { // 허용이 안된 경우
      // ignore: use_build_context_synchronously
      FlutterDialog(context);
    } else{
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var result = await gpsStationSearch(position.longitude, position.latitude);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => KakaoMapTest(x:position.latitude,y:position.longitude)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(221, 236, 202, 1),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.zero,top: Radius.circular(35)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5,right: 5),
                    child: IconButton(
                        onPressed: (){
                          // FlutterDialog();
                          getLocation();
                        },
                        icon: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116528450434506772/pngwing.com_1.png?width=590&height=590",scale:1),
                        iconSize: 40
                    ),
                  ),
                  Hero(
                      tag: "Search_Page",
                      child: Material(
                        type: MaterialType.transparency,
                        child: Container(
                          width:300,
                          child: TextField(
                            onTap: (){
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Search()));
                            },
                            keyboardType: TextInputType.none,
                            decoration: InputDecoration(
                              hintText: "노선 번호 또는 정류장 검색",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              suffixIcon: Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.search_outlined,size: 35,)
                              ),
                            ),
                          ),
                        ),
                      ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 5),
                width: double.infinity,
                height: 30,
                child: Text("노선 검색기록",style: TextStyle(fontSize: 20),),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(10)),
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
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432",scale: 5,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("300\n일반시내버스",style: TextStyle(fontSize: 18),),
                          padding: EdgeInsets.only(right: 20,left: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(10)),
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
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1139884238708146236/green_bus.png?width=460&height=460",scale: 5,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("1005\n직행좌석형시내버스",style: TextStyle(fontSize: 18,color: Colors.black),),
                          padding: EdgeInsets.only(right: 20,left: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(10)),
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
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1139884388683886623/green_bus.png?width=460&height=460",scale: 5,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("8-1\n마을버스",style: TextStyle(fontSize: 18,color: Colors.black),),
                          padding: EdgeInsets.only(right: 20,left: 10),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 5),
                width: double.infinity,
                height: 30,
                child: Text("정류장 검색기록",style: TextStyle(fontSize: 20),),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(10)),
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
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116527200972308560/bus-stop.png?width=590&height=590",scale:12,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("성남ㅣ매화마을4단지 (07632)",style: TextStyle(fontSize: 18),),
                          padding: EdgeInsets.only(right: 20,left: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(10)),
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
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116527200972308560/bus-stop.png?width=590&height=590",scale:12,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("성남ㅣ매화마을2단지 (07235)",style: TextStyle(fontSize: 18,color: Colors.black),),
                          padding: EdgeInsets.only(right: 20,left: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(10)),
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
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116527200972308560/bus-stop.png?width=590&height=590",scale:12,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("성남ㅣ분당아람고등학교 (07305)",style: TextStyle(fontSize: 18,color: Colors.black),),
                          padding: EdgeInsets.only(right: 20,left: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Text("🚨 완성되지 않은 앱으로 버그가 발생할 수 있습니다.",style: TextStyle(fontSize: 15),)
                  ),
                ],
              ),
            ],
          )
        )
      )
    );
  }
}