import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gritstone_technologies/core/data/services/database_services.dart';
import 'package:gritstone_technologies/core/data/services/locationservices.dart';
import 'package:gritstone_technologies/core/model/local_db/location_model/location_model.dart';

import 'hive_manager.dart';

Future<void> initializeServices() async {
  final services = FlutterBackgroundService();
  await services.configure(
      iosConfiguration: IosConfiguration(
          autoStart: true,
          onForeground: onStart,
          onBackground: onIosBackground),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
      ));
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance serviceInstance) async {
  // const platform =  MethodChannel('com.example/background_fetch');
  // platform.invokeMethod('enableBackgroundFetch');
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
onStart(ServiceInstance serviceInstance) async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveManager.initialize();
  DartPluginRegistrant.ensureInitialized();
  if (serviceInstance is AndroidServiceInstance) {
    serviceInstance.on('setAsForeground').listen((event) {
      serviceInstance.setAsForegroundService();
    });
    serviceInstance.on('setAsBackground').listen((event) {
      serviceInstance.setAsBackgroundService();
    });
  }
  serviceInstance.on('stopService').listen((event) {
    serviceInstance.stopSelf();
  });
  Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      if (serviceInstance is AndroidServiceInstance) {
        if (await serviceInstance.isForegroundService()) {
          serviceInstance.setForegroundNotificationInfo(
            title: "This demo application is runnig in background",
            content: "",
          );
        }
      }
      Position currentLocation = await LocationServices().getCurrentLocation();
      var battery = Battery();
      int? level = await battery.batteryLevel;
      log("${currentLocation.latitude}   ${DateTime.now()}     $level");
      DataBaseServices().addLocationData(
        locationModel: LocationModel(
          lat: currentLocation.latitude.toString(),
          lon: currentLocation.longitude.toString(),
          batteryLevel: level.toString(),
          currentTime: DateTime.now(),
        ),
      );
      serviceInstance.invoke('update');
    },
  );
}
