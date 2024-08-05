import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
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
  late Timer timer;
  var turn_number;
  var colors;
  var stars = Icon(Icons.star_border,color: Colors.yellow.shade900,size: 30,);

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

    timer = Timer.periodic(Duration(seconds: 10), (Timer timer) async{
      print("10초마다 데이터 다시 가져오기");
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
        } // 30초마다 데이터 다시 가져오기
      });

    if(widget.star_check){
      stars  = Icon(Icons.star,color: Colors.yellow.shade900,size: 30,);
    }else{
      stars  = Icon(Icons.star_border,color: Colors.yellow.shade900,size: 30,);
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

  @override
  void dispose() {
    timer.cancel(); // 화면이 나가면 타이머 중지
    super.dispose();
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
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        backgroundColor: colors,
        title: Text("실시간 버스 위치",style: TextStyle(fontSize: 20,color: Colors.white)),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity,120),
          child: Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: (){
                              moveScroll(0.0);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black38,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("상행노선",style: TextStyle(fontSize: 15, color: Colors.white),)
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: (){
                              moveScroll(double.parse((widget.turnYn+1).toString()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black38,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text("하행노선",style: TextStyle(fontSize: 15, color: Colors.white),)
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
              onPressed: ()async{
                var storage = await SharedPreferences.getInstance();
                var result = storage.getStringList('노선${widget.routeId}');
                if(result == null){
                  storage.setStringList('노선${widget.routeId}', [widget.line_info['regionName'],widget.line_info['routeId'],widget.line_info['routeName'],widget.line_info['routeTypeCd'],widget.line_info['routeTypeName']]);
                  manyfind("설정");
                  setState(() {
                    stars = Icon(Icons.star,color: Colors.yellow.shade900,size: 30,);
                  });
                }else{
                  storage.remove('노선${widget.routeId}');
                  manyfind("해제");
                  setState(() {
                    stars = Icon(Icons.star_border,color: Colors.yellow.shade900,size: 30,);
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
              child: CircularProgressIndicator(),
            );
            }else {
              return ListView.separated(
                shrinkWrap: true,
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
                        var results = storage.getStringList('정차${widget.stationlist[i]['mobileNo']}');
                        var star_check = results == null ? false : true;
                        var result;
                        try {
                          result = await busArrivalInfo(
                              widget.stationlist[i]['stationId']);
                        } catch (e) {
                          result = [{'routeId': '000000', 'routeName': "정보를 찾을 수 없음", "routeTypeName": "정보가 없습니다."}];
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Result_view(displayId: widget.stationlist[i]['stationId'], stationName: widget.stationlist[i]['stationName'], stationId: widget.stationlist[i]['mobileNo']==null ? data['${widget.stationlist[i]['stationId']}'] : widget.stationlist[i]['mobileNo'], stationInfo: result,starCheck:star_check)));
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          color: getColor(i),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if(i == 0)...[
                                Container(
                                    width: 60,
                                    height: 65,
                                    margin: EdgeInsets.only(left: 20),
                                    padding: EdgeInsets.zero,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/start.png'
                                      ),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ] else if(i == (widget.stationlist.length) - 1)...[
                                Container(
                                    width: 60,
                                    height: 65,
                                    margin: EdgeInsets.only(left: 20),
                                    padding: EdgeInsets.zero,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/last.png'
                                      ),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ] else if(widget.stationlist[i]['turnYn'] == "Y")...[
                                Container(
                                    width: 60,
                                    height: 65,
                                    margin: EdgeInsets.only(left: 20),
                                    padding: EdgeInsets.zero,
                                    child: Image(
                                      image: AssetImage(
                                          'assets/turn.png'
                                      ),
                                      fit: BoxFit.fill,
                                    )
                                ),
                              ] else...[
                                  Container(
                                      width: 60,
                                      height: 65,
                                      margin: EdgeInsets.only(left: 20),
                                      padding: EdgeInsets.zero,
                                      child: Image(
                                        image: AssetImage(
                                            'assets/line.png'
                                        ),
                                        fit: BoxFit.fill,
                                      )
                                  ),
                                ],
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.only(left: 10),
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
                              )
                            ],
                          ),
                        ),
                        if(bus_position.containsValue((i+1).toString()))...[
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 40,
                            height: 65,
                            margin: EdgeInsets.only(left: 30),
                            child: Image.asset("assets/bus_icon.png"),
                          ),
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
        backgroundColor: Color.fromRGBO(221, 236, 202, 1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40)
        ),
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
          Fluttertoast.showToast(
              msg: "새로고침 완료",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 15.0
          );
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
    await Future.delayed(Duration(seconds: 2));
    moveScroll(double.parse(staOrder));
  }
}