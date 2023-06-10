import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

busLineSeach(String number) async { // 버스 노선 조회 API
  var data = {};
  var result = await http.get(
      Uri.parse('http://openapi.gbis.go.kr/ws/rest/busrouteservice?serviceKey=1234567890&keyword=${number}'));
  if (result.statusCode == 200) { // API 응답 코드 (정상처리)
    var getXmlData = result.body; //XML 데이터 받기
    var Xml2JsonData = Xml2Json()..parse(getXmlData); // XML에서 JSON 형식으로 데이터 변환
    var jsonData = Xml2JsonData.toParker();
    data = jsonDecode(jsonData); //JSON 형식으로 디코딩
    var a = data['response']['msgBody']; // 필터링
    return (a['busRouteList']).toString(); // 값 반환
  } else {
    return "정보 불러오기 실패";
  }
}