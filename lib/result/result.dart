import 'package:flutter/material.dart';
import 'package:busapp/apis/api.dart';

class Result_view extends StatefulWidget {
  Result_view({super.key,this.storage});
  final storage;

  @override
  State<Result_view> createState() => _Result_viewState();
}

class _Result_viewState extends State<Result_view> {

  var data;
  var datas;
  var busarrival;
  var busarrivals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.blueAccent,
        title: Text("노선/정류장 검색 결과")
      ),
      body: Center(
        child: Text(
            "${widget.storage}",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
