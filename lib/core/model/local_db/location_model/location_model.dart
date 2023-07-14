import 'package:hive_flutter/hive_flutter.dart';

part 'location_model.g.dart';

@HiveType(typeId: 2)
class LocationModel {
  @HiveField(0)
  String lat;
  @HiveField(1)
  String lon;
  @HiveField(2)
  DateTime currentTime;
  @HiveField(3)
  String batteryLevel;

  LocationModel(
      {required this.lat,
      required this.lon,
      required this.batteryLevel,
      required this.currentTime});
}
