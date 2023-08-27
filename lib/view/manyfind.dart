import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apis/api.dart';
import '../result/busline_result.dart';

class ManyFind extends StatefulWidget {
  const ManyFind({super.key});

  @override
  State<ManyFind> createState() => _ManyFindState();
}

class _ManyFindState extends State<ManyFind> with TickerProviderStateMixin{

  var data = [];
  var colors;

  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );

  flutterToast(String a) {
    Fluttertoast.showToast(
        msg: "이 버스는 ${a} 입니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 15.0
    );
  }

  getdata() async{
    var storage = await SharedPreferences.getInstance();
    var results = storage.getKeys();
    results.forEach((i) {
      if(i.substring(0,2) == "노선"){
        setState(() {
          var resultss = storage.getStringList(i.toString());
          data.add(resultss);
        });
      }
    });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
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
        child: Column(
          children: [
            Container(
              child: TabBar(
                tabs: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      '버스노선',
                      style: TextStyle(fontSize: 17),),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      '정류장',
                      style: TextStyle(fontSize: 17),),
                  ),
                ],
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                controller: _tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: FutureBuilder(
                      future: _fetch1(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false) {
                          return Center(
                            child: Container(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }else {
                          return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (c, i) {
                                return TextButton(
                                  onPressed: () async{
                                    var storage = await SharedPreferences.getInstance();
                                    var results = storage.getStringList('노선${data[i][1].toString()}');
                                    var star_check = results == null ? false : true;
                                    var result;
                                    var result2;
                                    var result3;
                                    try{
                                      result = await busStationList(data[i][1]);
                                      result2 = await turnBus(data[i][1]);
                                    }catch(e){
                                      result = [{'routeId':'000000','routeName':"정보를 찾을 수 없음","routeTypeName":"정보가 없습니다."}];
                                    }
                                    try{
                                      result3 = await busLocationList(data[i][1]);
                                    }catch(e){
                                      result3 = null;
                                    }
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => BusLine_Result_view(stationlist:result,lineName:data[i][2],turnYn:result2,routeId:data[i][1],seachroute: false, staOrder:"0",busposition:result3,regionName:data[i][0].toString(),routeTypeName:data[i][4].toString(),star_check:star_check,line_info:data[i])));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Container(
                                      height: 70,
                                      width: double.infinity,
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(15),
                                              top: Radius.circular(15)),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.7),
                                              blurRadius: 1.0,
                                              spreadRadius: 0.0,
                                              offset: const Offset(0, 5),
                                            )
                                          ]
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 20),
                                              child: InkWell(
                                                child: getColor(
                                                    data[i][4]
                                                        .toString()),
                                                onTap: () {
                                                  flutterToast(
                                                      data[i][4]
                                                          .toString());
                                                },
                                              )
                                          ),
                                          Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width - 135,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .end,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 9, right: 10),
                                                    child: Text(
                                                      "${data[i][2]
                                                          .toString()}번",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 30),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Text(
                                                      "${data[i][0]
                                                          .toString()} 버스",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              )
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
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Tab2 View',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<String> _fetch1() async {
    await Future.delayed(Duration(milliseconds: 1));
    return 'Call Data';
  }
}
