import 'dart:io';

import 'package:flutter/material.dart';
import 'package:busapp/bus_line_info/bus_line_info.dart';
import 'package:busapp/result/result.dart';
import 'package:busapp/apis/api.dart';

class BusLine_Result_view extends StatefulWidget {
  const BusLine_Result_view({super.key,this.stationlist,this.lineName,this.turnYn,this.routeId,this.seachroute,this.staOrder});
  final stationlist;
  final lineName;
  final turnYn;
  final routeId;
  final seachroute;
  final staOrder;

  @override
  State<BusLine_Result_view> createState() => _BusLine_Result_viewState();
}

class _BusLine_Result_viewState extends State<BusLine_Result_view> {

  Map<String,String> data = {};
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void moveScroll(double a){
    scrollController.animateTo(
        65*a,
        duration: Duration(microseconds: 700),
        curve: Curves.ease
    );
  }

  getColor(a){
    var color;
    if((a+1)==int.parse(widget.staOrder) && widget.seachroute){
      moveScroll(double.parse(widget.staOrder));
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
        backgroundColor: Colors.blueAccent,
        title: Text("${widget.lineName}번 버스 노선"),
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
                      if (!widget.stationlist[i]['stationName']
                          .toString()
                          .contains("(경유)")) {
                        var result;
                        try {
                          result = await busArrivalInfo(
                              widget.stationlist[i]['stationId']);
                        } catch (e) {
                          result = [{
                            'routeId': '000000',
                            'routeName': "정보를 찾을 수 없음",
                            "routeTypeName": "정보가 없습니다."
                          }
                          ];
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (_) =>
                            Result_view(displayId: widget.stationlist[i]['stationId'],
                                station_name: widget.stationlist[i]['stationName'],
                                station_id: widget.stationlist[i]['mobileNo']==null ? data['${widget.stationlist[i]['stationId']}'] : widget.stationlist[i]['mobileNo'],
                                station_info: result)));
                      }
                    },
                    child: Container(
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
                          ] else
                            if (i == (widget.stationlist.length) - 1)...[
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
                            ] else
                              if (widget.stationlist[i]['turnYn'] == "Y")...[
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
                              ] else
                                ...[
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
                              width: 250,
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
        onPressed: (){
          print("새로고침");
        },
        child: Icon(Icons.restart_alt,size: 35,),
      ),
    );
  }
  Future<String> _fetch1() async {
    widget.stationlist.forEach((i) async{
      if(!i['stationName'].toString().contains("(경유)") && i['mobileNo']==null){
        var a = await busStationSearch2(
            i['stationName'],
            i['stationId']);
        data.addAll({"${i['stationId']}": "${a['mobileNo']}"});
      }
    });
    await Future.delayed(Duration(seconds: 1));
    return 'Call Data';
  }
}