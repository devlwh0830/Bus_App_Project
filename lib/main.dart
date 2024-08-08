import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:iconly/iconly.dart';
import 'view/main.dart';
import 'view/manyfind.dart';
import 'view/account.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Godo",
      ),
      home:  MyApp(),
    )
  );
}

enum _SelectedTab { home, star, location }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int tab = 0;
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      tab = i;
    });
  }

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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
            centerTitle: true,
            elevation: 0.0,
            scrolledUnderElevation: 0.0,
            backgroundColor: Color.fromRGBO(221, 236, 202, 1),
            title: Container(
              padding: EdgeInsets.fromLTRB(0, 26, 0, 0),
              width:250,
              height: 200,
              child: Image.asset('assets/header_logo.png'),
            ),
          ),
      ),
      body:Stack(
        alignment: Alignment.bottomCenter,
        children: [
          [Homes(),ManyFind(),Account()][tab],
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CrystalNavigationBar(
              currentIndex: _SelectedTab.values.indexOf(_selectedTab),
              borderRadius: 20.0,
              itemPadding: EdgeInsets.all(10),
              unselectedItemColor: Colors.white,
              backgroundColor: Colors.green.withOpacity(0.8),
              onTap: _handleIndexChanged,
              items: [
                /// Home
                CrystalNavigationBarItem(
                  icon: IconlyBold.home,
                  unselectedIcon: IconlyLight.home,
                  selectedColor: Colors.white,
                ),

                /// Favourite
                CrystalNavigationBarItem(
                  icon: IconlyBold.star,
                  unselectedIcon: IconlyLight.star,
                  selectedColor: Colors.yellow,
                ),

                /// Profile
                CrystalNavigationBarItem(
                  icon: IconlyBold.location,
                  unselectedIcon: IconlyLight.location,
                  selectedColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}