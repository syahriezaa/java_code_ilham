import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/sign_in/controlers/login_controllers.dart';
import 'package:magang/modules/features/sign_in/view/components/email_form.dart';
import 'package:magang/modules/features/sign_in/view/components/logo.dart';
import 'package:magang/modules/global_controllers/global_conection.dart';

import '../../../../../constant/common/conectivityStatus.dart';
import '../../../../models/auth_model.dart';

class LoginView extends StatelessWidget{
  var loginController = Get.put(LoginControllers());
   LoginView({Key? key}) : super(key: key);
 //  final ILogin _loginService = LoginService();
  var internetstatus= NewworkController();
  var password = LoginControllers().passwordEditingController;
  var email = LoginControllers().emailEditingController;
  @override
  Widget build(BuildContext context) {
    print(internetstatus.connectionStatusController);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/images/bg_login.png"),
                fit: BoxFit.cover,
                  ),
                ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Logo(),
                SizedBox(height: 50,),
                Container(
                  child: Text(' Masukan untuk melanjutkan!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ),
                Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                        children : <Widget>[

                          Container(
                            width: 350,
                            child: TextFormField(
                                controller:email ,
                              //onSaved: (input)=>requestmodel.email=input!,
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
                          ),
                          SizedBox(height: 20,),
                          Container(
                            width: 350,
                            child: TextFormField(

                              controller: password,
                              //onSaved: (input)=>requestmodel.password=input!,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (input)=>!input!.contains("@")?"email tidak valid":null,
                              decoration: InputDecoration(
                                hintText: '*************************',
                                labelText:'Alamat Email',
                                hintStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), //hint text style
                                labelStyle: TextStyle(fontSize: 13,), //label style
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                              ),

                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(
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
                                onPressed:(){LoginControllers.to.login(email.text, password.text);}

                                  ),
                              ),
                            ),

                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Expanded(
                                child: Divider(
                                  indent: 20.0,
                                  endIndent: 10.0,
                                  thickness: 1,
                                ),
                              ),
                              Text(
                                "Atau",
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                              Expanded(
                                child: Divider(
                                  indent: 10.0,
                                  endIndent: 20.0,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Container(
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
                                onPressed: ()async{
                                //Auth user =await _
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Container(
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
                              child: ElevatedButton(child: Image.asset('assets/images/login_apple.png'),

                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0)
                                        )
                                    ),
                                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                                        255, 0, 0, 0),
                                    )
                                ),
                                onPressed: null,
                              ),
                            ),
                          ),
                        ]
                    )
                )
              ],
            )
          ],
        )
    );
  }
}
