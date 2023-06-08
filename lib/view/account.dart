import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
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
                '준비중',
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
