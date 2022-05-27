import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswrodForm extends StatelessWidget {
  PasswrodForm({Key? key}) : super(key: key);
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(width: 350,
      child: TextFormField(
        controller: _passwordController,
        //onSaved: (input)=>requestmodel.password=input!,
        keyboardType: TextInputType.emailAddress,
        validator: (input)=>!input!.contains("@")?"email tidak valid":null,
        decoration: InputDecoration(
          hintText: '*************************',
          labelText:'Password',
          hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), //hint text style
          labelStyle: TextStyle(fontSize: 13,), //label style
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),

      ),);
  }
}
