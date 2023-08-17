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
      body: Stack(
        children: [
          KakaoMapView(
              width: double.infinity,
              height: double.infinity,
              kakaoMapKey: kakaoMapKey,
              lat: 33.45080604081833, //widget.x
              lng: 126.56900858718982, //widget.y
              showMapTypeControl: true,
              showZoomControl: true,
              markerImageURL:
              'https://media.discordapp.net/attachments/905797523363483659/1139879005844160622/-001.png',
              customScript: '''
    var markers = [];

    function addMarker(position) {

      var marker = new kakao.maps.Marker({position: position});

      marker.setMap(map);

      markers.push(marker);
    }

    for(var i = 0 ; i < 3 ; i++){
      addMarker(new kakao.maps.LatLng(33.450701 + 0.0003 * i, 126.570667 + 0.0003 * i));

      kakao.maps.event.addListener(markers[i], 'click', (function(i) {
        return function(){
          onTapMarker.postMessage('marker ' + i + ' is tapped');
        };
      })(i));
    }

		  var zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

      var mapTypeControl = new kakao.maps.MapTypeControl();
      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
              ''',
              onTapMarker: (c){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("정류장임")));
              }),
        ],
      ),
    );
  }
}

