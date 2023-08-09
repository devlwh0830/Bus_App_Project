import 'package:flutter/material.dart';

class NearStation extends StatefulWidget {
  const NearStation({super.key});

  @override
  State<NearStation> createState() => _NearStationState();
}

class _NearStationState extends State<NearStation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kakao map webview test')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // KakaoMapView

          ]
      ),
    );
  }
}
