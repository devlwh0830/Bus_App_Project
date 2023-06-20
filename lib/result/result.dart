import 'package:flutter/material.dart';

class Result_view extends StatefulWidget {
  Result_view({super.key,this.codes,this.name});
  final codes;
  final name;

  @override
  State<Result_view> createState() => _Result_viewState();
}

class _Result_viewState extends State<Result_view> {
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
            "RESULT: ${widget.name}\nID: ${widget.codes}\n검색결과 표시예정",
                style: TextStyle(
            fontSize: 50,
        ),
        ),
      ),
    );
  }
}
