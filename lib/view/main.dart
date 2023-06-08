import 'package:flutter/material.dart';

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
            children: [
              TextField(
                keyboardType: TextInputType.text,
                onChanged: (text){

                },
                decoration: InputDecoration(
                  hintText: "정류장 또는 정류장번호를 검색하세요.",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                      onPressed: (){

                      },
                      icon: Icon(Icons.search_outlined,size: 35,),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20,bottom: 5),
                width: double.infinity,
                height: 30,
                child: Text("검색기록",style: TextStyle(fontSize: 20),),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(10)),
                      color: Colors.greenAccent,
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432",scale: 5,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("300\n매화마을 2단지 (07235)(성남)",style: TextStyle(fontSize: 18),),
                          padding: EdgeInsets.only(right: 20,left: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(10)),
                      color: Colors.redAccent,
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432",scale: 5,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("1005\n매화마을 2단지 (07235)(성남)",style: TextStyle(fontSize: 18,color: Colors.white),),
                          padding: EdgeInsets.only(right: 20,left: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(10)),
                      color: Colors.yellowAccent,
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432",scale: 5,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("8-1\n매화마을 2단지 (07235)(성남)",style: TextStyle(fontSize: 18,color: Colors.black),),
                          padding: EdgeInsets.only(right: 20,left: 10),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10),top: Radius.circular(10)),
                      color: Colors.greenAccent,
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432",scale: 5,),
                          padding: EdgeInsets.only(left: 20),
                        ),
                        Container(
                          child: Text("250\n매화마을 2단지 (07235)(성남)",style: TextStyle(fontSize: 18,color: Colors.black),),
                          padding: EdgeInsets.only(right: 20,left: 10),
                        )
                      ],
                    ),
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
