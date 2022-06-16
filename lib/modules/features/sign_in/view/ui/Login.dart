import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magang/config/themes/colors.dart';
import 'package:magang/constant/core/assets_conts/asset_cons.dart';
import 'package:magang/modules/features/sign_in/controlers/login_controllers.dart';
import 'package:magang/modules/global_controllers/global_conection.dart';


class LoginView extends StatelessWidget{
  var loginController = Get.put(LoginControllers());
   LoginView({Key? key}) : super(key: key);
  var internetstatus= NewworkController();
  var password = LoginControllers().passwordEditingController;
  var email = LoginControllers().emailEditingController;
  @override
  Widget build(BuildContext context) {
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
    Container(
    child: Image.asset('assets/images/logo_login.png')
    ),
                SizedBox(height: 50,),
                Container(
                  child: Text('Sign in to Continue!'.tr,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
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
                                decoration: InputDecoration( labelText: 'Email'.tr,
                                  labelStyle: Theme.of(context).textTheme.bodySmall,
                                  hintText: 'Lorem.ipsum@gmail.com',
                                  hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: darkColor.withOpacity(0.25),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: blueColor, width: 2),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: blueColor, width: 2),
                                  ),
                              ),

                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            width: 350,
                            child: TextFormField(
                              controller: password,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (input)=>!input!.contains("@")?"email tidak valid":null,
                              decoration: InputDecoration(
                                labelText: 'Password'.tr,
                                labelStyle: Theme.of(context).textTheme.bodySmall,
                                hintText: '****************',
                                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: darkColor.withOpacity(0.25),
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: blueColor, width: 2),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: blueColor, width: 2),
                                ),
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
                              child: ElevatedButton(child: Text('Sign In'.tr,style: TextStyle(color: Colors.white,),),
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
                                "Or",
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
                              child: ElevatedButton(
                                onPressed:  ()async{
                                              LoginControllers.to.loginWithGoogle();
                                              },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  elevation: 4,
                                  padding: EdgeInsets.symmetric(horizontal: 36.r, vertical: 14.r),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AssetCons.googleIcon, width: 24.r, height: 24.r),
                                    const Spacer(),
                                    Text(
                                      'Login with'.tr,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.darkColor,
                                        height: 1.219,
                                      ),
                                    ),
                                    Text(
                                      ' Google',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.darkColor,
                                        height: 1.219,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              )
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
