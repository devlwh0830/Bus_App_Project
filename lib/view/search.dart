import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var data = ["집정류장", "회사정류장", "학교정류장", "한국정류장", "군대정류장", "병원정류장", "하늘나라정류장"];
  var input = "";

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
                  setState(() {
                    input = c;
                  });
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
          for(int i=0;i<data.length;i++)...[
            if(data[i].contains(input))...[
              TextButton(
                onPressed: (){
                  print("눌림");
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  margin:EdgeInsets.fromLTRB(10,0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15),top: Radius.circular(15)),
                    color: Colors.teal,
                  ),
                  child: Center(
                    child: Text(
                      data[i].toString(),
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                  ),
                ),
              ),
            ]
          ]
        ],
      ),
    );
  }
}
