import 'package:flutter/material.dart';
import 'package:busapp/apis/api.dart' as bus;
import 'package:busapp/result/arival_popup.dart';

class Result_view extends StatefulWidget {
  Result_view({super.key, this.displayId, this.station_name, this.station_id});
  final displayId;
  final station_name;
  final station_id;

  @override
  State<Result_view> createState() => _Result_viewState();
}

class _Result_viewState extends State<Result_view> {

  var colors;
  var storage;
  var result;
  var data;

  getName(a){
    try{
      if(a['arrivalInfo'][0]['time']<=180){
        return Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 5,right: 10),
              width: 90,
              child: Text(
                      "${a['name']}번",
                      style: TextStyle(color: Colors.white,fontSize: 30),
                      overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 8,right: 20),
              width: 175,
              child: Text(
                "잠시후 도착하는\n버스 입니다",
                style: TextStyle(color: Colors.white,fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      }else{
        return Container(
          padding: EdgeInsets.only(top: 13,right: 10),
          width: 250,
          child: Text(
            "${a['name']}번",
            style: TextStyle(color: Colors.white,fontSize: 30),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }
    }catch(e){
      return Container(
        padding: EdgeInsets.only(top: 13,right: 10),
        width: 250,
        child: Text(
          "${a['name']}번",
          style: TextStyle(color: Colors.white,fontSize: 30),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
  }
  
  getColor(String color){
    if(color == "직행좌석형시내버스" || color == "1211"){
      colors = Colors.redAccent;
    }else if(color == "좌석형시내버스" || color == "1212"){
      colors = Colors.blue;
    }else if(color == "일반형시내버스" || color == "1213"){
      colors = Colors.green;
    }else if(color == "광역급행형시내버스" || color == "1214"){
      colors = Colors.red;
    }else if(color == "마을버스" || color == "1230"){
      colors = Colors.yellow.shade800;
    }else if(color == "따복형 시내버스" || color == "1215"){
      colors = Colors.pink.shade800;
    }else if(color == "직행좌석형농어촌버스" || color == "1221"){
      colors = Colors.redAccent;
    }else if(color == "좌석형농어촌버스" || color == "1222"){
      colors = Colors.blue;
    }else if(color == "일반형농어촌버스" || color == "1223"){
      colors = Colors.green;
    }else if(color == "일반형시외버스" || color == "1243"){
      colors = Colors.purple;
    }else if(color == "리무진공항버스" || color == "1251"){
      colors = Colors.lime.shade800;
    }else if(color == "좌석형공항버스" || color == "1252"){
      colors = Colors.blueAccent;
    }else{
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
        children: <Widget>[

          // FutureBuilder 예시 코드
          FutureBuilder(
              future: fetchPost(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {

                //해당 부분은 data를 아직 받아 오지 못했을 때 실행되는 부분
                if (snapshot.hasData == false) {
                  return Center(
                      child: CircularProgressIndicator(),
                  );// CircularProgressIndicator : 로딩 에니메이션
                }

                //error가 발생하게 될 경우 반환하게 되는 부분
                else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Text(
                      'Error: ${snapshot.error}', // 에러명을 텍스트에 뿌려줌
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }

                // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 부분
                else {
                  return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20,bottom: 5),
                          margin:EdgeInsets.only(bottom: 10),
                          height: 100,
                          color: Colors.blueAccent,
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text("${widget.station_name}",style: TextStyle(fontSize: 25,color: Colors.white)),
                              Text("",style: TextStyle(fontSize: 5,color: Colors.white)),
                              Text("${widget.station_id}",style: TextStyle(fontSize: 20,color: Colors.white))
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 660,
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (c,i){
                                return TextButton(
                                  onPressed: (){
                                    FlutterDialog(context,snapshot.data[i]['name']);
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
                                        color: getColor("12"+snapshot.data[i]['type'][2]+snapshot.data[i]['type'][3]),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 20,right: 30),
                                            child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432"),
                                          ),
                                          Container(
                                              child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  getName(snapshot.data[i])
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
                  );
                }
              })
        ],
      )
    );
  }

  Future fetchPost() async {
    await Future.delayed(Duration(seconds: 2)); // 비동기 과정을 보여주기 위해 시간을 딜레이 시킨다.
    var dates = await bus.busArrivalInfo(widget.displayId);
    print(widget.displayId);
    return dates;
  }
}
