import 'package:flutter/material.dart';
import '/apis/api.dart';
import 'package:busapp/result/result.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var data;
  var datas;
  var stationdata;
  var stationdatas;
  var input = "";
  var colors;
  var storage;

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

  getBusArrivalInfo(String c) async {
    stationdata = await busArrivalInfo(c);
    setState((){
      storage = stationdata;
    });
  }

  getColor(String color){
    if(color == "직행좌석형시내버스"){
      colors = Colors.redAccent;
    }else if(color == "좌석형시내버스"){
      colors = Colors.blue;
    }else if(color == "일반형시내버스"){
      colors = Colors.green;
    }else if(color == "광역급행형시내버스"){
      colors = Colors.red;
    }else if(color == "마을버스"){
      colors = Colors.yellow;
    }else if(color == "따복형 시내버스"){
      colors = Colors.pink.shade900;
    }else if(color == "직행좌석형농어촌버스"){
      colors = Colors.redAccent;
    }else if(color == "좌석형농어촌버스"){
      colors = Colors.blue;
    }else if(color == "일반형농어촌버스"){
      colors = Colors.green;
    }else if(color == "일반형시외버스"){
      colors = Colors.purple;
    }else if(color == "리무진공항버스"){
      colors = Colors.lime.shade800;
    }else if(color == "좌석형공항버스"){
      colors = Colors.blueAccent;
    }else{
      colors = Colors.grey;
    }
    return colors;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      data = [{"routeName":"N/A","routeTypeName":"N/A","regionName":"N/A","routeId":"N/A"}];
      stationdatas = [{"name":"검색 결과 없음","displayId":"검색 결과 없음","id":"000000"}];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Hero(
          tag: "Search_Page",
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width:double.infinity,
              padding: EdgeInsets.only(right: 20,top: 60, bottom: 20),
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
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20,top: 5,bottom: 5),
            alignment: Alignment.centerLeft,
            child: Text("노선 검색 결과",style: TextStyle(fontSize: 20),),
          ),
          Container(
            width: double.infinity,
            height: 350,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (c,i){
                  return TextButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Result_view(storage:storage)));
                      print(data[i]['routeId']);
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
                          color: getColor(data[i]['routeTypeName'].toString()),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432"),
                            ),
                            Container(
                                width: 280,
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 9,right: 10),
                                      child: Text(
                                        "${data[i]['routeName'].toString()}번",
                                        style: TextStyle(color: Colors.white,fontSize: 30),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text(
                                        "${data[i]['regionName'].toString()}버스",
                                        style: TextStyle(color: Colors.white,fontSize: 15),
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
            padding: EdgeInsets.only(left: 20,top: 5,bottom: 5),
            alignment: Alignment.centerLeft,
            child: Text("정류장 검색 결과",style: TextStyle(fontSize: 20),),
          ),
          Container(
            width: double.infinity,
            height: 300,
            child: ListView.builder(
                itemCount: stationdatas.length,
                itemBuilder: (c,i){
                  return TextButton(
                    onPressed: (){
                      getBusArrivalInfo(stationdatas[i]['id']);
                      Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Result_view(storage:storage)));
                      print(stationdatas[i]['id']);
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
                                      width: 250,
                                      child: Text(
                                        "${stationdatas[i]['name']}",
                                        style: TextStyle(color: Colors.white,fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text(
                                        "정류장코드 : ${stationdatas[i]['displayId']}",
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
    );
  }
}
