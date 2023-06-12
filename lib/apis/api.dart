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
  var data = [];
  var url = 'https://api.yhs.kr/bus/station?name=$name&cityCode=12';
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // 요청이 성공한 경우 응답 데이터 처리
    data = jsonDecode(utf8.decode(response.bodyBytes));
    return data;
  } else{
    return [{"name":"검색 결과 없음","displayId":"검색 결과 없음","id":"000000"}];
  }
}
