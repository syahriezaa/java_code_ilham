import 'package:flutter/material.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.8),
          spreadRadius: 0.5,
          blurRadius: 10,
          offset: Offset(0, 7), // changes position of shadow
        ),
      ],
    ),
      child: SizedBox(
        width: 336,
        height: 44,
        child: ElevatedButton(child: Image.asset('assets/images/login_google.png'),

          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)
                  )
              ),
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                  255, 255, 255, 255),
              )
          ),
          onPressed: null,
        ),
      ),);
  }
}
