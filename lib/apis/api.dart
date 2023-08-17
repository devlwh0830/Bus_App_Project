import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

busLineSearch(String number) async { // 버스 노선 조회 API
  var data = {};
  var datas = [];
  var result = await http.get(
      Uri.parse('http://openapi.gbis.go.kr/ws/rest/busrouteservice?serviceKey=1234567890&keyword=${number}'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var getXmlData = result.body; //XML 데이터 받기
    var Xml2JsonData = Xml2Json()..parse(getXmlData); // XML에서 JSON 형식으로 데이터 변환
    var jsonData = Xml2JsonData.toParker();
    data = jsonDecode(jsonData); //JSON 형식으로 디코딩
    data = data['response']['msgBody']; // 필터링
    try{
      datas = data['busRouteList'];
    }catch (e){
      datas.add(data['busRouteList']);
    }
    return datas; // 값 반환
  }
}

busStationSearch(String name) async { // 정류장 조회 API
  var data = {};
  var datas = [];
  var result = await http.get(
      Uri.parse('http://openapi.gbis.go.kr/ws/rest/busstationservice?serviceKey=1234567890&keyword=$name'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var getXmlData = result.body; //XML 데이터 받기
    var Xml2JsonData = Xml2Json()..parse(getXmlData); // XML에서 JSON 형식으로 데이터 변환
    var jsonData = Xml2JsonData.toParker();
    data = jsonDecode(jsonData); //JSON 형식으로 디코딩
    data = data['response']['msgBody']; // 필터링
    datas = data['busStationList'];
    return datas; // 값 반환
  }
}

busStationSearch2(String name,String Id) async { // 정류장 5자리 고유번호 조회용
  var data = {};
  var datas = [];
  var result = await http.get(
      Uri.parse('http://openapi.gbis.go.kr/ws/rest/busstationservice?serviceKey=1234567890&keyword=$name'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var getXmlData = result.body; //XML 데이터 받기
    var Xml2JsonData = Xml2Json()..parse(getXmlData); // XML에서 JSON 형식으로 데이터 변환
    var jsonData = Xml2JsonData.toParker();
    data = jsonDecode(jsonData); //JSON 형식으로 디코딩
    data = data['response']['msgBody']; // 필터링
    try{
      datas = data['busStationList'];
      for(int i=0;i<datas.length;i++){
        if(datas[i]['stationId']==Id){
          return datas[i];
        }
      }
    }catch(e){
      return data['busStationList'];
    }
  }
}

busArrivalInfo(stationId) async { // 정류장 버스 정보
  var data = {};
  var datas = [];
  var result = await http.get(
      Uri.parse('http://openapi.gbis.go.kr/ws/rest/busstationservice/route?serviceKey=1234567890&stationId=$stationId'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var getXmlData = result.body; //XML 데이터 받기
    var Xml2JsonData = Xml2Json()..parse(getXmlData); // XML에서 JSON 형식으로 데이터 변환
    var jsonData = Xml2JsonData.toParker();
    data = jsonDecode(jsonData); //JSON 형식으로 디코딩
    data = data['response']['msgBody']; // 필터링
    try{
      datas = data['busRouteList'];
    }catch (e){
      datas.add(data['busRouteList']);
    }
    return datas; // 값 반환
  }
}

busRouteName(routeId) async { // 버스 정보
  var data = {};
  var datas;
  var result = await http.get(
      Uri.parse('http://openapi.gbis.go.kr/ws/rest/busrouteservice/info?serviceKey=1234567890&routeId=$routeId'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var getXmlData = result.body; //XML 데이터 받기
    var Xml2JsonData = Xml2Json()..parse(getXmlData); // XML에서 JSON 형식으로 데이터 변환
    var jsonData = Xml2JsonData.toParker();
    data = jsonDecode(jsonData); //JSON 형식으로 디코딩
    data = data['response']['msgBody']; // 필터링
    datas = data['busRouteInfoItem'];
    return datas;
  }
}

busStationList(routeId) async { // 정류장 리스트 정보
  var data = {};
  var datas;
  var result = await http.get(
      Uri.parse('http://openapi.gbis.go.kr/ws/rest/busrouteservice/station?serviceKey=1234567890&routeId=$routeId'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var getXmlData = result.body; //XML 데이터 받기
    var Xml2JsonData = Xml2Json()..parse(getXmlData); // XML에서 JSON 형식으로 데이터 변환
    var jsonData = Xml2JsonData.toParker();
    data = jsonDecode(jsonData); //JSON 형식으로 디코딩
    data = data['response']['msgBody']; // 필터링
    datas = data['busRouteStationList'];
    return datas;
  }
}

turnBus(routeId) async { // 회차 정류장 번호
  var data = {};
  var datas;
  var result = await http.get(
      Uri.parse('http://openapi.gbis.go.kr/ws/rest/busrouteservice/station?serviceKey=1234567890&routeId=$routeId'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var getXmlData = result.body; //XML 데이터 받기
    var Xml2JsonData = Xml2Json()..parse(getXmlData); // XML에서 JSON 형식으로 데이터 변환
    var jsonData = Xml2JsonData.toParker();
    data = jsonDecode(jsonData); //JSON 형식으로 디코딩
    data = data['response']['msgBody']; // 필터링
    datas = data['busRouteStationList'];
    for(int i=0;i<datas.length;i++){
      if(datas[i]['turnYn']=="Y"){
        return i;
      }
    }
  }
}

busLocationList(routeId) async { // 버스 위치 리스트
  var data={};
  var datas=[];
  var result = await http.get(
      Uri.parse('http://openapi.gbis.go.kr/ws/rest/buslocationservice?serviceKey=1234567890&routeId=$routeId'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var getXmlData = result.body; //XML 데이터 받기
    var Xml2JsonData = Xml2Json()..parse(getXmlData); // XML에서 JSON 형식으로 데이터 변환
    var jsonData = Xml2JsonData.toParker();
    data = jsonDecode(jsonData); //JSON 형식으로 디코딩
    data = data['response']['msgBody']; // 필터링
    try{
      datas = data['busLocationList'];
    }catch (e){
      datas.add(data['busLocationList']);
    }
    print(datas[0]);
    return datas;
  }
}

gpsStationSearch(posX, posY) async { // GPS 기반 정류장 조회 API
  var data = [];
  var url = 'https://api.yhs.kr/bus/station/around?posX=$posX&posY=$posY&cityCode=12';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // 요청이 성공한 경우 응답 데이터 처리
    data = jsonDecode(utf8.decode(response.bodyBytes));
    return data;
  }
}