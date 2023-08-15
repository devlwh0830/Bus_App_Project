import 'package:flutter/material.dart';

class bus_line_info extends StatefulWidget {
  const bus_line_info({super.key,this.lineName});
  final lineName;

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
        child: Text("구현예정"),
      ),
    );
  }
}
