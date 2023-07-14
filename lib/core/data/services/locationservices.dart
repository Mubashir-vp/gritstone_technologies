import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationServices {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location sevices are disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are perminently denied, We cannot access it");
    }
    return await Geolocator.getCurrentPosition();
  }

  String? getLivelocation() {
    String message = '';
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      message =
          "Langitude:${position.latitude} Longitude:${position.longitude},";
    });
    return message;
  }
}
