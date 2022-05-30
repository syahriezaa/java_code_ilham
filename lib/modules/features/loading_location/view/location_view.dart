import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magang/modules/features/loading_location/controller/location_controller.dart';

class LoadingLocation extends GetView<LocationController> {
  const LoadingLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LocationController());
    return Scaffold(
      body : Stack(
        alignment: Alignment.center,
        children:<Widget> [
          SizedBox(
            height:500,
            width:220,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_location.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                     child: Text("Mencari Lokasimu ....", ),
                  ),
                ]
    ),

                Container(
                  child: Image.asset('assets/images/loading_map.png'),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                  SizedBox(
                   height:80,
                    width:300,

                    child: Obx(
                        ()=> Text(controller.addres.value,style: TextStyle(fontSize:20),textAlign:TextAlign.center)
                    ),
                  ),
                ],
              ),

            ],
          ),
        ],
      )
    );
  }
}
