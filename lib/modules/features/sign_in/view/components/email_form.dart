import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailForm extends StatelessWidget {
  EmailForm(TextEditingController textEditingController, {Key? key}) : super(key: key);
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (input)=>!input!.contains("@")?"email tidak valid":null,
        decoration: InputDecoration(
          hintText: 'Lorem.ipsum@gmial.com',
          labelText:'Alamat Email',
          hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), //hint text style
          labelStyle: TextStyle(fontSize: 13,), //label style
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),

      ),
    );
  }
}
