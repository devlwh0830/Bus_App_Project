import 'package:flutter/material.dart';

class bus_line_info extends StatefulWidget {
  const bus_line_info({super.key,this.lineName,this.result});
  final lineName;
  final result;

  @override
  State<bus_line_info> createState() => _bus_line_infoState();
}

class _bus_line_infoState extends State<bus_line_info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.blueAccent,
        title: Text("${widget.lineName}번 노선 정보"),
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),
                    width: 390,
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                      color: Colors.grey,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 10,top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("운수업체 | ${widget.result['companyName']}",style: TextStyle(fontSize: 20,color: Colors.black),),
                          Text("전화번호 | ${widget.result['companyTel']}",style: TextStyle(fontSize: 20,color: Colors.black),),
                        ],
                      )
                    )
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  width: 390,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                    color: Colors.grey,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10,top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("운행구간 | ${widget.result['startStationName']} <-> ${widget.result['endStationName']}",style: TextStyle(fontSize: 20,color: Colors.black),),
                        ],
                      )
                  )
              ),
              Container(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  width: 390,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                    color: Colors.grey,
                  ),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10,top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("평일배차시간 : ${widget.result['peekAlloc']} ~ ${widget.result['nPeekAlloc']}분",style: TextStyle(fontSize: 20),),
                        ],
                      )
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      width: 390,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                        color: Colors.grey,
                      ),
                      child: Container(
                          margin: EdgeInsets.only(left: 10,top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("평일종점 첫차 출발시간 : ${widget.result['downFirstTime']}",style: TextStyle(fontSize: 20),),
                              Text("평일종점 막차 출발시간 : ${widget.result['downLastTime']}",style: TextStyle(fontSize: 20),),
                            ],
                          )
                      )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      width: 390,
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                        color: Colors.grey,
                      ),
                      child: Container(
                          margin: EdgeInsets.only(left: 10,top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("평일기점 첫차 출발시간 : ${widget.result['upFirstTime']}",style: TextStyle(fontSize: 20),),
                              Text("평일기점 막차 출발시간 : ${widget.result['upLastTime']}",style: TextStyle(fontSize: 20),),
                            ],
                          )
                      )
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text("🚨 배차시간은 기상 또는 교통상황에 따라 변동될 수 있습니다.",style: TextStyle(fontSize: 15),),
              )
            ],
          ),
        )
      ),
    );
  }
}
