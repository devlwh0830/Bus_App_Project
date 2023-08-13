import 'package:flutter/material.dart';
import 'package:busapp/result/error_report.dart';

class BusLine_Result_view extends StatefulWidget {
  const BusLine_Result_view({super.key});

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
          title: Text("버스 노선 검색결과")
      ),
      body: Center(
        child: Text(
          "여기까지 만들면 나는 죽어요ㅜㅜ\n구현예정",
          style: TextStyle(fontSize: 25),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          error_reports(context);
        },
        icon: Icon(Icons.message),
        backgroundColor: Colors.red,
        label: Text('오류신고'),
      ),
    );
  }
}