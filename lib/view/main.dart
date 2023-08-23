import 'package:busapp/view/kakaomap.dart';
import 'package:busapp/result/busline_result.dart';
import 'package:busapp/result/result.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:busapp/apis/api.dart';
import 'search.dart';
import 'popup.dart';

class Homes extends StatefulWidget {
  const Homes({super.key});

  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(221, 236, 202, 1),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.zero,top: Radius.circular(35)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Hero(
                  tag: "Search_Page",
                  child: Material(
                    type: MaterialType.transparency,
                    child: Container(
                      child: TextField(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Search()));
                        },
                        keyboardType: TextInputType.none,
                        decoration: InputDecoration(
                          hintText: "노선 번호 또는 정류장 검색",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(Icons.search_outlined,size: 35,)
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 5),
                width: double.infinity,
                height: 30,
                child: Text("최근 노선 검색기록",style: TextStyle(fontSize: 20),),
              ),
              Column(
                children: [
                  Container(
                    height: 200,
                    child: Center(
                      child: Text("🛠️ 다음 버전에서 업데이트 됩니다.",style: TextStyle(fontSize: 20),),
                    )
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 5),
                width: double.infinity,
                height: 30,
                child: Text("최근 정류장 검색기록",style: TextStyle(fontSize: 20),),
              ),
              Column(
                children: [
                  Container(
                      height: 170,
                      child: Center(
                        child: Text("🛠️ 다음 버전에서 업데이트 됩니다.",style: TextStyle(fontSize: 20),),
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Text("🚨 완성되지 않은 앱으로 버그가 발생할 수 있습니다.",style: TextStyle(fontSize: 15),)
                  ),
                ],
              ),
            ],
          )
        )
      )
    );
  }
}