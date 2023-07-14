import 'dart:developer';
import 'dart:io';

import 'package:gritstone_technologies/core/model/local_db/location_model/location_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../model/local_db/hive_model/hive_model.dart';
import 'hive_manager.dart';

class DataBaseServices {
  static Box<LocationModel>? _locationBox;

  static Future<void> initializeHive() async {
    Directory path = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(path.path);
    Hive.registerAdapter(LocationModelAdapter());
    await Hive.openBox<LocationModel>('location_box');
  }

  static Box<LocationModel> getLocationBox() {
    _locationBox ??= Hive.box<LocationModel>('location_box');
    List<int> keys = _locationBox!.keys.cast<int>().toList();
    log("Length in getLocationBox${keys.length}************************");
    return _locationBox!;
  }

  addData({
    required HiveModel product,
  }) async {
    Box<HiveModel> box = Hive.box('hive_box');
    await box.clear();
    await box.add(product);
  }

  HiveModel? getData() {
    Box<HiveModel> dataBox = Hive.box('hive_box');
    if (dataBox.isEmpty) {
      return null;
    } else {
      List<HiveModel> hiveModel = dataBox.values.toList();
      return hiveModel[0];
    }
  }

  List<int> getLocationData() {
    Box<LocationModel> dataBox = Hive.box('location_data');

    return dataBox.keys.cast<int>().toList();
  }

  addLocationData({required LocationModel locationModel}) async {
    Box<LocationModel> locationBox = await HiveManager.getLocationBox();
    List<int> keys = locationBox.keys.cast<int>().toList();
    log("Length${keys.length}");
    locationBox.add(locationModel);
  }
}
