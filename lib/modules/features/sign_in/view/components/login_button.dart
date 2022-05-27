import 'package:flutter/material.dart';
class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 0.5,
            blurRadius: 10,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: SizedBox(
        width: 336,
        height: 44,
        child: ElevatedButton(child: Text('Masuk',style: TextStyle(color: Colors.white,),),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)
                  )
              ),
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 0, 154, 173),
              )
          ),
          onPressed: (){
            // if(validateAndSave()){
            //   print(requestmodel.toJson());
            // }
          },
        ),
      ),);
  }
}
