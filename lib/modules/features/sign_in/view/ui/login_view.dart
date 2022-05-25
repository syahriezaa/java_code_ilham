import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Background extends StatelessWidget {
  const Background ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
            Container(
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("asset/images/bacground.png"),
              fit: BoxFit.cover,
            ),
            ),
          ),
        ],
    )
    );
  }
}
