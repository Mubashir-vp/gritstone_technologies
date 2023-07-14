import 'dart:io';

import 'package:gritstone_technologies/core/model/local_db/location_model/location_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveManager {
  static late Box<LocationModel> _locationBox;

  static Future<void> initialize() async {
    Directory path = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(path.path);
    Hive.registerAdapter(LocationModelAdapter());
    await openLocationBox();
  }

  static Future<void> openLocationBox() async {
    _locationBox = await Hive.openBox<LocationModel>('location_box');
    // List<int> keys = _locationBox.keys.cast<int>().toList();
    // log("Length in openLocationBox: ${keys.length}");
  }

  static Future<Box<LocationModel>> getLocationBox() async {
    await openLocationBox();
    return _locationBox;
  }
}
