import 'package:hive_flutter/hive_flutter.dart';

import '../local_product_model.dart/local_product_model.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 1)
class HiveModel {
  @HiveField(0)
  List<LocalProduct> products;
  @HiveField(1)
  List<LocalProduct> category;

  HiveModel({
    required this.category,
    required this.products,
  });
}
