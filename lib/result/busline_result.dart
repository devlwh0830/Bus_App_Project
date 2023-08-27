import 'dart:convert';

import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:flutter/material.dart';
import 'package:busapp/bus_line_info/bus_line_info.dart';
import 'package:busapp/result/result.dart';
import 'package:busapp/apis/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusLine_Result_view extends StatefulWidget {
  const BusLine_Result_view({super.key,this.stationlist,this.lineName,this.turnYn,this.routeId,this.seachroute,this.staOrder,this.busposition,this.regionName,this.routeTypeName,this.star_check,this.line_info});
  final stationlist;
  final lineName;
  final turnYn;
  final routeId;
  final seachroute;
  final staOrder;
  final busposition;
  final regionName;
  final routeTypeName;
  final star_check;
  final line_info;

  @override
  State<BusLine_Result_view> createState() => _BusLine_Result_viewState();
}

class _BusLine_Result_viewState extends State<BusLine_Result_view> with SingleTickerProviderStateMixin{

  Map<String,String> data = {};
  ScrollController scrollController = ScrollController();
  Map<String,String> bus_position = {};
  Map<String,String> bus_position_update = {};
  var turn_number;
  var colors;
  var stars = Icon(Icons.star_border,color: Colors.yellow,size: 30,);

  flutterToast() {
    Fluttertoast.showToast(
        msg: "버스 위치 정보가 없습니다.",
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.star_check){
      stars  = Icon(Icons.star,color: Colors.yellow,size: 30,);
    }else{
      stars  = Icon(Icons.star_border,color: Colors.yellow,size: 30,);
    }
    if(widget.routeTypeName == "직행좌석형시내버스"){
      colors = Colors.redAccent;
    }else if(widget.routeTypeName == "좌석형시내버스"){
      colors = Colors.blueAccent;
    }else if(widget.routeTypeName == "일반형시내버스"){
      colors = Colors.green.shade600;
    }else if(widget.routeTypeName == "광역급행형시내버스"){
      colors = Colors.redAccent;
    }else if(widget.routeTypeName == "마을버스"){
      colors = Colors.yellow.shade700;
    }else if(widget.routeTypeName == "따복형 시내버스"){
      colors = Colors.green.shade600;
    }else if(widget.routeTypeName == "직행좌석형농어촌버스"){
      colors = Colors.redAccent;
    }else if(widget.routeTypeName == "좌석형농어촌버스"){
      colors = Colors.green.shade600;
    }else if(widget.routeTypeName == "일반형농어촌버스"){
      colors = Colors.green.shade600;
    }else if(widget.routeTypeName == "일반형시외버스"){
      colors = Colors.green.shade600;
    }else if(widget.routeTypeName == "리무진형 공항버스"){
      colors = Colors.grey;
    }else if(widget.routeTypeName == "좌석형 공항버스"){
      colors = Colors.grey;
    }else{
      colors = Colors.grey;
    }
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      fetchDataAndPerformAction(widget.staOrder); // 모든 작업이 완료되면 함수 호출
    });
    if(widget.busposition != null){
      widget.busposition.forEach((i){
        setState(() {
          bus_position.addAll({"${i['stationSeq']}${i['plateNo']}":"${i['stationSeq']}"});
        });
      });
    }else{
      flutterToast();
    }
  }

  void moveScroll(double a){
    scrollController.animateTo(
        65*(a-1),
        duration: Duration(seconds: 1),
        curve: Curves.ease);
  }

  getColor(a){
    var color;
    if((a+1)==int.parse(widget.staOrder) && widget.seachroute){
      color =  Colors.yellow.shade100;
    }else{
      color = Colors.white;
    }
    return color;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 5.0,
        backgroundColor: colors,
        title: Text("실시간 버스 위치"),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity,110),
          child: Container(
            width: double.infinity,
            height: 110,
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  "${widget.lineName}번",
                  style: TextStyle(fontSize: 25,color: Colors.white),
                ),
                Text(
                  "${widget.regionName}",
                  style: TextStyle(fontSize: 15,color: Colors.white),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 45,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: double.infinity,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: (){
                              moveScroll(0.0);
                            },
                            child: Text("상행노선",style: TextStyle(fontSize: 15),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black38,
                              elevation: 0.0,
                            )
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        width: 200,
                        child: ElevatedButton(
                            onPressed: (){
                              moveScroll(double.parse((widget.turnYn+1).toString()));
                            },
                            child: Text("하행노선",style: TextStyle(fontSize: 15),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black38,
                              elevation: 0.0,
                            )
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async{
                var result;
                result = await busRouteName(widget.routeId);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => bus_line_info(lineName:widget.lineName,result:result)));
              },
              icon: Icon(
                Icons.info_outline_rounded,
                size: 30,
              )
          ),
          IconButton(
              onPressed: ()async{
                var storage = await SharedPreferences.getInstance();
                var result = storage.getStringList('노선${widget.routeId}');
                if(result == null){
                  storage.setStringList('노선${widget.routeId}', [widget.line_info['regionName'],widget.line_info['routeId'],widget.line_info['routeName'],widget.line_info['routeTypeCd'],widget.line_info['routeTypeName']]);
                  manyfind("설정");
                  setState(() {
                    stars = Icon(Icons.star,color: Colors.yellow,size: 30,);
                  });
                }else{
                  storage.remove('노선${widget.routeId}');
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
      body: FutureBuilder(
        future: _fetch1(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
            }else {
              return ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.zero,
                itemCount: widget.stationlist.length,
                itemBuilder: (c, i) {
                  return TextButton(
                    style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        padding: EdgeInsets.zero
                    ),
                    onPressed: () async {
                      if (!widget.stationlist[i]['stationName'].toString().contains("(경유)")) {
                        var storage = await SharedPreferences.getInstance();
                        var results = storage.getString('정차${widget.stationlist[i]['mobileNo']}');
                        var star_check = results == null ? false : true;
                        var result;
                        try {
                          result = await busArrivalInfo(
                              widget.stationlist[i]['stationId']);
                        } catch (e) {
                          result = [{'routeId': '000000', 'routeName': "정보를 찾을 수 없음", "routeTypeName": "정보가 없습니다."}];
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Result_view(displayId: widget.stationlist[i]['stationId'], station_name: widget.stationlist[i]['stationName'], station_id: widget.stationlist[i]['mobileNo']==null ? data['${widget.stationlist[i]['stationId']}'] : widget.stationlist[i]['mobileNo'], station_info: result,star_check:star_check)));
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          color: getColor(i),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if(i == 0)...[
                                Container(
                                    width: 60,
                                    height: 65,
                                    margin: EdgeInsets.only(left: 60),
                                    padding: EdgeInsets.zero,
                                    child: Image(
                                      image: NetworkImage(
                                          "https://media.discordapp.net/attachments/905797523363483659/1140636007180542062/-001_4.png?width=460&height=460"
                                      ),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ] else if(i == (widget.stationlist.length) - 1)...[
                                Container(
                                    width: 60,
                                    height: 65,
                                    margin: EdgeInsets.only(left: 60),
                                    padding: EdgeInsets.zero,
                                    child: Image(
                                      image: NetworkImage(
                                          "https://media.discordapp.net/attachments/905797523363483659/1140636006903722095/-001_5.png?width=460&height=460"
                                      ),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ] else if(widget.stationlist[i]['turnYn'] == "Y")...[
                                Container(
                                    width: 60,
                                    height: 65,
                                    margin: EdgeInsets.only(left: 60),
                                    padding: EdgeInsets.zero,
                                    child: Image(
                                      image: NetworkImage(
                                          "https://media.discordapp.net/attachments/905797523363483659/1140636824918831205/-001_6.png?width=460&height=460"
                                      ),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ] else...[
                                  Container(
                                      width: 60,
                                      height: 65,
                                      margin: EdgeInsets.only(left: 60),
                                      padding: EdgeInsets.zero,
                                      child: Image(
                                        image: NetworkImage(
                                            "https://media.discordapp.net/attachments/905797523363483659/1140625711326048346/-001_1.png?width=460&height=460"
                                        ),
                                        fit: BoxFit.fill,
                                      )
                                  ),
                                ],
                              Container(
                                  height: 40,
                                  margin: EdgeInsets.only(left: 10),
                                  width: MediaQuery.of(context).size.width - 150,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if(widget.stationlist[i]['stationName']
                                          .toString()
                                          .contains("(경유)"))...[
                                        Text(
                                            "${widget.stationlist[i]['stationName']}",
                                            style: TextStyle(
                                                fontSize: 20, color: Colors.grey),
                                            overflow: TextOverflow.ellipsis
                                        ),
                                        Text(
                                            "미정차 | ${widget
                                                .stationlist[i]['regionName']}",
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.grey),
                                            overflow: TextOverflow.ellipsis
                                        ),
                                      ] else
                                        ...[
                                          Text(
                                              "${widget
                                                  .stationlist[i]['stationName']}",
                                              style: TextStyle(fontSize: 20,
                                                  color: widget.turnYn > i ? Colors
                                                      .blue : Colors.red),
                                              overflow: TextOverflow.ellipsis
                                          ),
                                          if(widget.stationlist[i]['mobileNo']==null)...[
                                            Text(
                                                "${data['${widget.stationlist[i]['stationId']}']} | ${widget.stationlist[i]['regionName']}",
                                                style: TextStyle(
                                                    fontSize: 15, color: Colors.grey),
                                                overflow: TextOverflow.ellipsis
                                            ),
                                          ]else...[
                                            Text(
                                                "${widget
                                                    .stationlist[i]['mobileNo']} | ${widget
                                                    .stationlist[i]['regionName']}",
                                                style: TextStyle(
                                                    fontSize: 15, color: Colors.grey),
                                                overflow: TextOverflow.ellipsis
                                            ),
                                          ]

                                        ]
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                        if(bus_position.containsValue((i+1).toString()))...[
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                alignment: Alignment.center,
                                child: Text("정차 또는\n    이동중",style: TextStyle(fontSize: 15),),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 40,
                                height: 65,
                                child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1141336135893798964/-001_1.png?width=460&height=460"),
                              ),
                            ],
                          )
                        ]
                      ],
                    )
                  );
                },
                separatorBuilder: (BuildContext ctx, int idx) {
                  return Divider(
                    color: Colors.black,
                    thickness: 0.5,
                    height: 0.5,
                  );
                },
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          bus_position.clear();
          var result;
          try{
            result = await busLocationList(widget.routeId);
          }catch(e){
            result = null;
          }
          if(result != null) {
            result.forEach((i) {
              setState(() {
                bus_position.addAll({"${i['stationSeq']}${i['plateNo']}": "${i['stationSeq']}"});
              });
            });
          }else{
            flutterToast();
          }
        },
        child: Icon(Icons.refresh_outlined,size: 35,),
      ),
    );
  }
  Future<String> _fetch1() async {
    widget.stationlist.forEach((i) async{
      if(!i['stationName'].toString().contains("(경유)") && i['mobileNo']==null){
        var a = await busStationSearch2(
            i['stationName'].toString(),
            i['stationId'].toString());
        data.addAll({"${i['stationId']}": "${a['mobileNo']}"});
      }
    });

    await Future.delayed(Duration(seconds: 1));
    return 'Call Data';
  }
  void fetchDataAndPerformAction(staOrder) async{
    // 여기에 원하는 작업 수행
    await Future.delayed(Duration(seconds: 1));
    moveScroll(double.parse(staOrder));
  }
}