import 'package:flutter/material.dart';
import 'package:busapp/bus_line_info/bus_line_info.dart';
import 'package:busapp/result/result.dart';
import 'package:busapp/apis/api.dart';

class BusLine_Result_view extends StatefulWidget {
  const BusLine_Result_view({super.key,this.stationlist,this.lineName});
  final stationlist;
  final lineName;

  @override
  State<BusLine_Result_view> createState() => _BusLine_Result_viewState();
}

class _BusLine_Result_viewState extends State<BusLine_Result_view> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => bus_line_info(lineName:widget.lineName)));
              },
              icon: Icon(
                Icons.info_outline_rounded,
                size: 30,
              )
          )
        ],
      ),
      body: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: widget.stationlist.length,
          itemBuilder: (c, i) {
            return TextButton(
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                padding: EdgeInsets.zero
              ),
              onPressed: ()async{
                var result;
                try{
                  result = await busArrivalInfo(widget.stationlist[i]['stationId']);
                }catch(e){
                  result = [{'routeId':'000000','routeName':"정보를 찾을 수 없음","routeTypeName":"정보가 없습니다."}];
                }
                Navigator.push(context, MaterialPageRoute(builder: (_) => Result_view(displayId:widget.stationlist[i]['stationId'],station_name: widget.stationlist[i]['stationName'],station_id:widget.stationlist[i]['mobileNo'],station_info:result)));
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if(i==0)...[
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
                    ]else if (i==(widget.stationlist.length)-1)...[
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
                    ]else if (i==((widget.stationlist.length-1)/2).floor())...[
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
                    ]else...[
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
                            Text(
                                "${widget.stationlist[i]['stationName']}",
                                style: TextStyle(fontSize: 20,color: i<(widget.stationlist.length/2) ? Colors.blue : Colors.red),
                                overflow: TextOverflow.ellipsis
                            ),
                            Text(
                                "${widget.stationlist[i]['mobileNo']} | ${widget.stationlist[i]['regionName']}",
                                style: TextStyle(fontSize: 15,color: Colors.grey),
                                overflow: TextOverflow.ellipsis
                            ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("새로고침");
        },
        child: Icon(Icons.restart_alt,size: 35,),
      ),
    );
  }
}