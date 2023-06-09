import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

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
      FlutterDialog();
    } else{
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      getLocations(position.latitude,position.longitude);
    }
  }

  void FlutterDialog() {
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
            children: <Widget>[
              Text("위치 권한을 먼저 허용해 주세요."),
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
                "위치 권한이 없는 경우 주변 정류장\n검색 서비스를 사용할 수 없습니다.",
              textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
            )
          ),
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

  void getLocations(x,y) {
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
            children: <Widget>[
              Text("위치 조회 성공"),
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
                  "귀하의 현재 위치 좌표 정보 입니다.\nX좌표 : ${x}\nY좌표 : ${y}",
                  textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
              )
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("닫기"),
            )
          ],
        );
      },
    );
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
                  Container(
                    width:300,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (text){

                      },
                      decoration: InputDecoration(
                        hintText: "노선 번호 또는 정류장 검색",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: IconButton(
                            onPressed: (){

                            },
                            icon: Icon(Icons.search_outlined,size: 35,),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                      color: Colors.greenAccent,
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432",scale: 5,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("300\n매화마을 2단지 (07235)(성남)",style: TextStyle(fontSize: 18),),
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
                      color: Colors.redAccent,
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432",scale: 5,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("1005\n매화마을 2단지 (07235)(성남)",style: TextStyle(fontSize: 18,color: Colors.white),),
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
                      color: Colors.yellowAccent,
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432",scale: 5,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("8-1\n매화마을 2단지 (07235)(성남)",style: TextStyle(fontSize: 18,color: Colors.black),),
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
                      color: Colors.cyan,
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
                      color: Colors.cyan,
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
                      color: Colors.cyan,
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
                ],
              ),
            ],
          )
        )
      )
    );
  }
}

