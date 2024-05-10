import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apis/api.dart';
import '../result/result.dart';

const String kakaoMapKey = 'c3d6d190928c3d74537e09ad175926fd';

flutterToast(String a) {
  Fluttertoast.showToast(
      msg: a,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 15.0
  );
}

void KakaoDialog(context,station_info) {
  showDialog(
    context: context,
    //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
        title: Container(
          width: 500,
          child: Text("정류장 위치를 확인하세요.\n${station_info['stationName']} (${station_info['distance']}m)",style: TextStyle(fontSize: 15),),
        ),
        content: Container(
            height: 500,
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 0,
                  blurRadius: 5.0,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: KakaoMapView(
                width: double.infinity,
                height: MediaQuery.of(context).size.height-400,
                kakaoMapKey: kakaoMapKey,
                lat: double.parse(station_info['y']), //widget.x
                lng: double.parse(station_info['x']), //widget.y
                showMapTypeControl: true,
                showZoomControl: true,
                zoomLevel: 3,
                overlayText: "Text",
                markerImageURL: 'https://media.discordapp.net/attachments/905797523363483659/1237417461356298393/-001.png?ex=663b9250&is=663a40d0&hm=a0d78da21a3b9c22b768fddc9fc9c51fb7f41f0626dc1a168fa135c8ec7bd35b&=&format=webp&quality=lossless&width=424&height=424',
                customScript: '''
                var markers = [];
            
                function addMarker(position) {
            
                  var marker = new kakao.maps.Marker({position: position});
            
                  marker.setMap(map);
            
                  markers.push(marker);
                }
            
                for(var i = 0 ; i < 2 ; i++){
                  addMarker(new kakao.maps.LatLng(${double.parse(station_info['y']).toString()}, ${double.parse(station_info['x']).toString()}));
            
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
                  flutterToast("${station_info['stationName']} 정류장은\n현재 위치로부터 ${station_info['distance']}m 앞에 있어요.");
                }),
        ),
        titlePadding: EdgeInsets.only(left: 15,bottom: 15,top: 15,right: 50),
        contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 5),
        actionsPadding: EdgeInsets.only(right: 15,bottom: 5),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("닫기"),
          ),
          TextButton(
            onPressed: () async{
              var storage = await SharedPreferences.getInstance();
              var results = storage.getString('정차${station_info['mobileNo']}');
              var star_check = results == null ? false : true;
              var result;
              try{
                result = await busArrivalInfo(station_info['stationId']);
              }catch(e){
                result = [{'routeId':'000000','routeName':"정보를 찾을 수 없음","routeTypeName":"정보가 없습니다."}];
              }
              Navigator.push(context, MaterialPageRoute(builder: (_) => Result_view(displayId:station_info['stationId'],stationName: station_info['stationName'],stationId:station_info['mobileNo'],stationInfo:result,starCheck:star_check)));
            },
            child: Text("정류장조회"),
          ),
        ],
      );
    },
  );
}

