import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'search.dart';

class Homes extends StatefulWidget {
  const Homes({super.key});

  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> {

  @override
  Widget build(BuildContext context) {

    onButtonTap() async {
      await launchUrlString("https://www.gg.go.kr/contents/contents.do?ciIdx=1003&menuId=2287",mode: LaunchMode.platformDefault);
    }

    onButtonTap2() async {
      await launchUrlString("https://www.gg.go.kr/contents/contents.do?ciIdx=629&menuId=2344",mode: LaunchMode.platformDefault);
    }

    void toast(){
      Fluttertoast.showToast(
          msg: "외부 사이트로 이동 합니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black12,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

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
                child: Text("오늘도 좋은 하루 되세요!",style: TextStyle(fontSize: 20),),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 5,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    height: 500,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.7),
                            blurRadius: 1.0,
                            spreadRadius: 0.0,
                            offset: const Offset(0, 5),
                          )
                        ]
                    ),
                    child: Center(
                      child: Text("업데이트 예정",style: TextStyle(fontSize: 20),),
                    ),
                  ),
              ),
              Flexible(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child:InkWell(
                            child: Container(
                              height: 90,
                              width: 200,
                              margin: EdgeInsets.only(top: 5,right: 5,bottom: 5),
                              decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(
                                          0.7),
                                      blurRadius: 1.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(0, 5),
                                    )
                                  ]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.report_gmailerrorred_rounded,size: 35,color: Colors.redAccent,),
                                  Text("무정차신고",style: TextStyle(fontSize: 18),)
                                ],
                              ),
                            ),
                            onTap: (){
                              onButtonTap();
                              toast();
                            },
                          )
                        ),
                        Flexible(
                            child:InkWell(
                              child: Container(
                                height: 90,
                                width: 200,
                                margin: EdgeInsets.only(top: 5,left: 5,bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(
                                            0.7),
                                        blurRadius: 1.0,
                                        spreadRadius: 0.0,
                                        offset: const Offset(0, 5),
                                      )
                                    ]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.monetization_on_rounded,size: 35,),
                                    Text("버스요금",style: TextStyle(fontSize: 18),)
                                  ],
                                ),
                              ),
                              onTap: (){
                                onButtonTap2();
                                toast();
                              },
                            )
                        )
                      ],
                    ),
                  )
              )
            ],
          )
        )
      )
    );
  }
}