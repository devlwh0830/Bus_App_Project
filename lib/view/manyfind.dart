import 'package:flutter/material.dart';

class ManyFind extends StatefulWidget {
  const ManyFind({super.key});

  @override
  State<ManyFind> createState() => _ManyFindState();
}

class _ManyFindState extends State<ManyFind> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(221, 236, 202, 1),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.zero,top: Radius.circular(35)),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
              '    😥 즐겨찾기로\n등록된 정보가 없어요.',
              style: TextStyle(
                  fontFamily: 'Godo',
                  fontSize: 25
              )
          ),
        )
      ),
    );
  }
}
