import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';


class LocationController extends GetxController{
  var latitude = 'Mendapatkan Latitude..'.obs;
  var longtitude = 'Mendapatkan Latitude..'.obs;
  var addres = 'Mendapatkan Latitude..'.obs;
  late  StreamSubscription<Position>streamSubscription;

  void onInit()async{
    super.onInit();
    getLocation();
  }
  getLocation()async{
    bool serviceEnabled ;

    LocationPermission permision;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      //akses lokasi belum di izinkan dan meminta akses
      await Geolocator.openLocationSettings();
      return Future.error("lokasi belum di izinkan");
    }
    permision = await Geolocator.checkPermission();
    if (permision == LocationPermission.denied){
      permision= await Geolocator.requestPermission();
      if(permision == LocationPermission.denied){
        return Future.error("Lokasi tidak di izinkan");
      }
    }
    streamSubscription=Geolocator.getPositionStream().listen((Position position){
      latitude.value='Latitude: ${position.latitude}';
      longtitude.value='Longitude: ${position.longitude}';
      GetAddressFromPosition(position);
    });
  }

  Future <void> GetAddressFromPosition(Position position)async{
    List<Placemark>placemark=
    await placemarkFromCoordinates(position.latitude,position.longitude);
    Placemark place = placemark[0];
    addres.value = ' ${place.name} ,${place.locality},${place.subAdministrativeArea},${place.postalCode}';
  }
}
