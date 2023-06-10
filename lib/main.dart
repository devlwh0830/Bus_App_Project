import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'view/main.dart';
import 'view/manyfind.dart';
import 'view/account.dart';
import 'apis/api.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: "Godo",
      ),
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
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Color.fromRGBO(221, 236, 202, 1),
            title: Container(
              padding: EdgeInsets.fromLTRB(0, 26, 0, 0),
              width:250,
              height: 200,
              child: Image.network("https://media.discordapp.net/attachments/905797523363483659/1116317186177368064/header_logo.png?width=500&height=125"),
            ),
          ),
      ),
      body:[Homes(),ManyFind(),Account()][tab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
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