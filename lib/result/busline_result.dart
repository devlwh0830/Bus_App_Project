import 'package:flutter/material.dart';
import 'package:busapp/bus_line_info/bus_line_info.dart';

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
      body: ListView.builder(
          itemCount: widget.stationlist.length,
          itemBuilder: (c, i) {
            return TextButton(
              onPressed: (){
                print(i);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1.0
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                        child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116527200972308560/bus-stop.png?width=590&height=590",scale:12,)
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 50),
                      width: 300,
                      child: Text(
                          "${widget.stationlist[i]['stationName']}",
                          style: TextStyle(fontSize: 20,color: i<(widget.stationlist.length/2) ? Colors.blue : Colors.red),
                          overflow: TextOverflow.ellipsis
                      ),
                    )
                  ],
                ),
              )
            );
          }
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