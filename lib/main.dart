import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MaterialApp(
      home:  MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var tab  = 0;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(221, 236, 202, 1),
      ),
      body:[Container(
        width: double.infinity,
        height: 150,
        color: Color.fromRGBO(221, 236, 202, 1),
        child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '정류장을 검색하세요.',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.blue)
                )
            )
        ),
      ),
        Text('즐겨찾기',style: TextStyle(fontSize: 100),),
        Text('내정보',style: TextStyle(fontSize: 100),)][tab],
      bottomNavigationBar: BottomNavigationBar(
        //현재 index 변수에 저장
        currentIndex: tab,
        //tap -> index 변경
        onTap: (index) {
          setState(() {
            tab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '메인',
            activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline),
            label: '즐겨찾기',
            activeIcon: Icon(Icons.star)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '내정보',
            activeIcon: Icon(Icons.account_circle)
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}