import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  var latitute;
  var longitude;
LocationPermission ?permission;


   
  Future<void> getCurrentLocation() async {
    permission = await Geolocator.requestPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitute = position.latitude;
      longitude = position.longitude;
      
    } catch (e) {
      print(e);
    }
  }
}
