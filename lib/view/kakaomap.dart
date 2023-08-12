import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String kakaoMapKey = 'c3d6d190928c3d74537e09ad175926fd';

class KakaoMapTest extends StatefulWidget {
  const KakaoMapTest({super.key, this.x, this.y});
  final x;
  final y;

  @override
  State<KakaoMapTest> createState() => _KakaoMapTestState();
}

class _KakaoMapTestState extends State<KakaoMapTest> {

  flutterToast() {
    Fluttertoast.showToast(
        msg: "귀하의 현재 위치 입니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('주변 정류장 찾기')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // KakaoMapView
          KakaoMapView(
              width: double.infinity,
              height: 700,
              kakaoMapKey: kakaoMapKey,
              lat: widget.x,
              lng: widget.y,
              showMapTypeControl: true,
              showZoomControl: true,
              markerImageURL:
              'https://media.discordapp.net/attachments/905797523363483659/1139879005844160622/-001.png',
              onTapMarker: (c){
                flutterToast();
              }),
        ],
      ),
    );
  }
}

