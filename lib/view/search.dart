import '/apis/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as foundation;
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

  var search;
  var data;
  var data_list;
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
    datas = await busLineSearch(c,_isChecked1,_isChecked2,_isChecked3,_isChecked4,_isChecked5);
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
      colors = Image.asset("assets/red_bus.png");
    }else if(color == "좌석형시내버스"){
      colors = Image.asset("assets/red_bus.png");
    }else if(color == "일반형시내버스"){
      colors = Image.asset("assets/green_bus.png");
    }else if(color == "광역급행형시내버스"){
      colors = Image.asset("assets/red_bus.png");
    }else if(color == "마을버스"){
      colors = Image.asset("assets/yellow_bus.png");
    }else if(color == "따복형 시내버스"){
      colors = Image.asset("assets/gray_bus.png");
    }else if(color == "직행좌석형농어촌버스"){
      colors = Image.asset("assets/gray_bus.png");
    }else if(color == "좌석형농어촌버스"){
      colors = Image.asset("assets/gray_bus.png");
    }else if(color == "일반형농어촌버스"){
      colors = Image.asset("assets/gray_bus.png");
    }else if(color == "일반형시외버스"){
      colors = Image.asset("assets/gray_bus.png");
    }else if(color == "리무진형 공항버스"){
      colors = Image.asset("assets/gray_bus.png");
    }else if(color == "좌석형 공항버스"){
      colors = Image.asset("assets/gray_bus.png");
    }else{
      colors = Image.asset("assets/gray_bus.png");
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
        preferredSize: Size.fromHeight(100.0),
        child: Hero(
          tag: "Search_Page",
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width:double.infinity,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.only(right: 20,top: 60, bottom: 10),
              child: TextField(
                onChanged: (c){
                  setState(() {
                    search = c;
                  });
                  getData(search);
                  getStationData(search);
                },
                onEditingComplete: (){
                  FocusScope.of(context).unfocus();
                  getData(search.toString());
                  getStationData(search.toString());
                },
                onTap: (){
                  FocusScope.of(context).unfocus();
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
      body:Column(
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
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                                    color: Color.fromRGBO(221, 236, 202, 1)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "광역",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: Checkbox(
                                        value: _isChecked1,
                                        activeColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        onChanged: (value){
                                          setState(() {
                                            _isChecked1 = value!;
                                          });
                                          getData(search);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                                    color: Color.fromRGBO(221, 236, 202, 1)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 3),
                                      child: Text(
                                        "직행",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: Checkbox(
                                        value: _isChecked2,
                                        activeColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        onChanged: (value){
                                          setState(() {
                                            _isChecked2 = value!;
                                          });
                                          getData(search);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                                    color: Color.fromRGBO(221, 236, 202, 1)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 3),
                                      child: Text(
                                        "일반",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: Checkbox(
                                        value: _isChecked3,
                                        activeColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        onChanged: (value){
                                          setState(() {
                                            _isChecked3 = value!;
                                          });
                                          getData(search);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                                    color: Color.fromRGBO(221, 236, 202, 1)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 3),
                                      child: Text(
                                        "마을",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: Checkbox(
                                        value: _isChecked4,
                                        activeColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        onChanged: (value){
                                          setState(() {
                                            _isChecked4 = value!;
                                          });
                                          getData(search);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                                    color: Color.fromRGBO(221, 236, 202, 1)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 3),
                                      child: Text(
                                        "기타",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: Checkbox(
                                        value: _isChecked5,
                                        activeColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        onChanged: (value){
                                          setState(() {
                                            _isChecked5 = value!;
                                          });
                                          getData(search);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (c,i){
                              if(data[i]['routeName'].toString() == "00"){
                                return Center(
                                  child: Text("검색 결과가 없습니다."),
                                );
                              }else{
                                return TextButton(
                                  onPressed: () async{
                                    if(data[i]['routeName'].toString() != "00"){
                                      var storage = await SharedPreferences.getInstance();
                                      var results = storage.getStringList('노선${data[i]['routeId']}');
                                      var star_check = results == null ? false : true;
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
                                          context, MaterialPageRoute(builder: (_) => BusLine_Result_view(stationlist:result,lineName:data[i]['routeName'],turnYn:result2,routeId:data[i]['routeId'],seachroute: false, staOrder:"0",busposition:result3,regionName:data[i]['regionName'].toString(),routeTypeName:data[i]['routeTypeName'].toString(),star_check:star_check,line_info:data[i])));
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Container(
                                      padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                                          color: Colors.white,
                                          border: Border.all(color: Colors.black),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ]
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          InkWell(
                                            child: SizedBox(
                                              width: 60,
                                              height: 60,
                                              child: getColor(data[i]['routeTypeName'].toString()),
                                            ),
                                            onTap: (){
                                              flutterToast(data[i]['routeTypeName'].toString());
                                            },
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${data[i]['routeName'].toString()}번",
                                                  style: TextStyle(color: Colors.black,fontSize: 30),
                                                ),
                                                Text(
                                                  "${data[i]['regionName'].toString()} 버스",
                                                  style: TextStyle(color: Colors.black,fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                );
                              }
                            }
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: stationdatas.length,
                          itemBuilder: (c,i){
                            if(stationdatas[i]['stationName'] == "검색 결과 없음"){
                              return Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: 10),
                                child: Text("검색 결과가 없습니다."),
                              );
                            }else{
                              return TextButton(
                                onPressed: () async{
                                  if(stationdatas[i]['stationName'] != "검색 결과 없음"){
                                    var storage = await SharedPreferences.getInstance();
                                    var results = storage.getStringList('정차${stationdatas[i]['mobileNo']}');
                                    var star_check = results == null ? false : true;
                                    var result;
                                    try{
                                      result = await busArrivalInfo(stationdatas[i]['stationId']);
                                    }catch(e){
                                      result = [{'routeId':'000000','routeName':"정보를 찾을 수 없음","routeTypeName":"정보가 없습니다."}];
                                    }
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => Result_view(displayId:stationdatas[i]['stationId'],stationName: stationdatas[i]['stationName'],stationId:stationdatas[i]['mobileNo'],stationInfo:result,starCheck:star_check)));
                                  }
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ]
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Icon(Icons.directions_bus,color: Colors.green,size: 30,),
                                        ),
                                        SizedBox(width: 20,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${stationdatas[i]['stationName']}",
                                              style: TextStyle(color: Colors.black,fontSize: 20),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "정류장코드 : ${stationdatas[i]['mobileNo'] ?? "정보없음"} (${stationdatas[i]['regionName']})",
                                              style: TextStyle(color: Colors.black,fontSize: 15),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                ),
                              );
                            }
                          }
                      ),
                    )
                  ],
                )
            )
          ]
      ),
    );
  }
}
