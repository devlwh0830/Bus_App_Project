import 'package:busapp/result/arival_popup.dart';
import 'package:flutter/material.dart';
import '/apis/api.dart';
import 'package:busapp/result/result.dart';
import 'package:busapp/result/busline_result.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search>  with TickerProviderStateMixin{

  late TabController _result_viewState;

  var data;
  var datas;
  var stationdata;
  var stationdatas;
  var input = "";
  var colors;
  var storage;
  var list = [];
  var _isChecked1 = true;
  var _isChecked2 = true;
  var _isChecked3 = true;
  var _isChecked4 = true;
  var _isChecked5 = true;

  flutterToast(String a) {
    Fluttertoast.showToast(
        msg: "이 버스는 ${a} 입니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 15.0
    );
  }

  getData(String c) async {
    datas = await busLineSearch(c);
    setState((){
      data = datas;
    });
  }

  getStationData(String c) async {
    stationdata = await busStationSearch(c);
    setState((){
      stationdatas = stationdata;
    });
  }

  getBusEndStation(a)async{
    datas = await busRouteName(a);
    return datas['endStationName'];
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
    _result_viewState = TabController(
      length: 2,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );
    super.initState();
    setState(() {
      data = [{"routeName":"00","routeTypeName":"정보없음","regionName":"정보없음","routeId":"N/A"}];
      stationdatas = [{"stationName":"검색 결과 없음","regionName":"N/A","mobileNo":"검색 결과 없음","id":"000000"}];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: Hero(
          tag: "Search_Page",
          child: Material(
            type: MaterialType.transparency,
            child: Column(
              children: [
                Container(
                  width:double.infinity,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.only(right: 20,top: 60, bottom: 10),
                  child: TextField(
                    onChanged: (c){
                      getData(c);
                      getStationData(c);
                    },
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "노선번호 또는 정류장명으로 검색하세요.",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        icon: IconButton(
                          padding: EdgeInsets.only(left: 20),
                          color: Colors.black,
                          icon: Icon(Icons.close,size: 30,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        )
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5,top: 1),
                        child: Text(
                          "광역",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: Container(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _isChecked1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (value){
                              setState(() {
                                _isChecked1 = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15,right: 5,top: 1),
                        child: Text(
                          "직행",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: Container(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _isChecked2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (value){
                              setState(() {
                                _isChecked2 = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15,right: 5,top: 1),
                        child: Text(
                          "일반",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: Container(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _isChecked3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (value){
                              setState(() {
                                _isChecked3 = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15,right: 5,top: 1),
                        child: Text(
                          "마을",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: Container(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _isChecked4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (value){
                              setState(() {
                                _isChecked4 = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15,right: 5,top: 1),
                        child: Text(
                          "기타",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: Container(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: _isChecked5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (value){
                              setState(() {
                                _isChecked5 = value!;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
        ),
      ),
      body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                child: TabBar(
                  tabs: [
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        '버스노선',
                        style: TextStyle(fontSize: 17),),
                    ),
                    Container(
                      height: 40,
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
                  controller: _result_viewState,
                ),
              ),
                Expanded(
                  child: TabBarView(
                    controller: _result_viewState,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 350,
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (c,i){
                              return TextButton(
                                onPressed: () async{
                                  if(data[i]['routeName'].toString() != "00"){
                                    var result;
                                    var result2;
                                    var result3;
                                    try{
                                      result = await busStationList(data[i]['routeId']);
                                      result2 = await turnBus(data[i]['routeId']);
                                    }catch(e){
                                      result = [{'routeId':'000000','routeName':"정보를 찾을 수 없음","routeTypeName":"정보가 없습니다."}];
                                    }
                                    try{
                                      result3 = await busLocationList(data[i]['routeId']);
                                    }catch(e){
                                      result3 = null;
                                    }
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => BusLine_Result_view(stationlist:result,lineName:data[i]['routeName'],turnYn:result2,routeId:data[i]['routeId'],seachroute: false, staOrder:"0",busposition:result3,regionName:data[i]['regionName'].toString(),routeTypeName:data[i]['routeTypeName'].toString())));
                                  }
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  margin:EdgeInsets.fromLTRB(10,0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: InkWell(
                                            child: getColor(data[i]['routeTypeName'].toString()),
                                            onTap: (){
                                              flutterToast(data[i]['routeTypeName'].toString());
                                            },
                                          )
                                      ),
                                      Container(
                                          width: MediaQuery.of(context).size.width-135,
                                          child:Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(top: 9,right: 10),
                                                child: Text(
                                                  "${data[i]['routeName'].toString()}번",
                                                  style: TextStyle(color: Colors.black,fontSize: 30),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(right: 10),
                                                child: Text(
                                                  "${data[i]['regionName'].toString()} 버스",
                                                  style: TextStyle(color: Colors.black,fontSize: 15),
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
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 300,
                        child: ListView.builder(
                            itemCount: stationdatas.length,
                            itemBuilder: (c,i){
                              return TextButton(
                                onPressed: () async{
                                  if(stationdatas[i]['stationName'] != "검색 결과 없음"){
                                    var result;
                                    try{
                                      result = await busArrivalInfo(stationdatas[i]['stationId']);
                                    }catch(e){
                                      result = [{'routeId':'000000','routeName':"정보를 찾을 수 없음","routeTypeName":"정보가 없습니다."}];
                                    }
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => Result_view(displayId:stationdatas[i]['stationId'],station_name: stationdatas[i]['stationName'],station_id:stationdatas[i]['mobileNo'],station_info:result)));
                                  }
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
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
                                                  width: MediaQuery.of(context).size.width - 140,
                                                  child: Text(
                                                    "${stationdatas[i]['stationName']}",
                                                    style: TextStyle(color: Colors.white,fontSize: 20),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(right: 10),
                                                  child: Text(
                                                    "정류장코드 : ${stationdatas[i]['mobileNo']} (${stationdatas[i]['regionName']})",
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
                            }
                        ),
                      ),
                    ],
                  )
                )
            ]
        ),
    );
  }
}
