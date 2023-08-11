import 'package:flutter/material.dart';
import 'package:busapp/apis/api.dart';
import 'package:busapp/result/arival_popup.dart';

class Result_view extends StatefulWidget {
  Result_view({super.key, this.displayId, this.station_name, this.station_id,this.station_info});
  final displayId;
  final station_name;
  final station_id;
  final station_info;

  @override
  State<Result_view> createState() => _Result_viewState();
}

class _Result_viewState extends State<Result_view> {

  var colors;
  var storage;
  var result;
  var lineName;

  // Future<Widget> getData(a) async {
  //   var datas = await busRouteName(a['routeId']);
  //   lineName = datas['routeName'];
  //   return
  // }

  getColor(color) {
    if (color == "직행좌석형시내버스" || color == "1211") {
      colors = Colors.redAccent;
    } else if (color == "좌석형시내버스" || color == "1212") {
      colors = Colors.blue;
    } else if (color == "일반형시내버스" || color == "1213") {
      colors = Colors.green;
    } else if (color == "광역급행형시내버스" || color == "1214") {
      colors = Colors.red;
    } else if (color == "마을버스" || color == "1230") {
      colors = Colors.yellow.shade800;
    } else if (color == "따복형 시내버스" || color == "1215") {
      colors = Colors.pink.shade800;
    } else if (color == "직행좌석형농어촌버스" || color == "1221") {
      colors = Colors.redAccent;
    } else if (color == "좌석형농어촌버스" || color == "1222") {
      colors = Colors.blue;
    } else if (color == "일반형농어촌버스" || color == "1223") {
      colors = Colors.green;
    } else if (color == "일반형시외버스" || color == "1243") {
      colors = Colors.purple;
    } else if (color == "리무진공항버스" || color == "1251") {
      colors = Colors.lime.shade800;
    } else if (color == "좌석형공항버스" || color == "1252") {
      colors = Colors.blueAccent;
    } else {
      colors = Colors.grey;
    }
    return colors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.blueAccent,
            title: Text("노선/정류장 검색 결과")
        ),
        body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                margin: EdgeInsets.only(bottom: 10),
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
                height: 660,
                child: ListView.builder(
                    itemCount: widget.station_info.length,
                    itemBuilder: (c, i) {
                      return TextButton(
                        onPressed: () async {
                          FlutterDialog(context,widget.station_info[i]['routeName']);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: Container(
                            height: 60,
                            width: double.infinity,
                            margin: EdgeInsets.fromLTRB(
                                10, 0, 10, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(15),
                                  top: Radius.circular(15)),
                              color: getColor(widget.station_info[i]['routeTypeName']),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 30),
                                  child: Image.network(
                                      "https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432"),
                                ),
                                Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(top:8, right: 10),
                                          width: 200,
                                          child: Text(
                                            "${widget.station_info[i]['routeName']}\n${widget.station_info[i]['routeTypeName']}",
                                            style: TextStyle(color: Colors.white, fontSize: 20),
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
            ]
        )
    );
  }
}