import 'package:flutter/material.dart';
import '/apis/api.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var data;
  var datas;
  var input = "";

  getData(String c) async {
    datas = await busLineSeach(c);
    setState((){
      data = datas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        children: [
          TextButton(
            onPressed: (){
              print("눌림");
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: Container(
              height: 700,
              width: double.infinity,
              margin:EdgeInsets.fromLTRB(10,0, 10, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                color: Colors.teal,
              ),
              child: Center(
                child: Text(
                  data.toString(),
                  style: TextStyle(color: Colors.white,fontSize: 10),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
