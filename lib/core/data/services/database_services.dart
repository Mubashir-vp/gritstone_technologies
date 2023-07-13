import 'dart:developer';

import 'package:hive/hive.dart';

import '../../model/local_db/hive_model/hive_model.dart';

class DataBaseServices {
  addData({
    required HiveModel product,
  }) async {
    log('Adding function ${product.category[0].title}');
    Box<HiveModel> box = Hive.box('hive_box');
    await box.clear();
    await box.add(product);
  }

  HiveModel getData() {
    Box<HiveModel> dataBox = Hive.box('hive_box');
    List<HiveModel> hiveModel = dataBox.values.toList();
    return hiveModel[0];
  }
}
