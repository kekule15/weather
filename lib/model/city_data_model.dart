import 'package:hive/hive.dart';
part 'city_data_model.g.dart';

@HiveType(typeId: 0)
class CityDataModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  double lat;
  @HiveField(2)
  double long;

  CityDataModel({
    required this.name,
    required this.lat,
    required this.long,
  });

  factory CityDataModel.fromJson(Map<String, dynamic> json) =>
      CityDataModel(name: json["name"], lat: json["lat"], long: json["long"]);

  Map<String, dynamic> toJson() => {"name": name, "lat": lat, "long": long};
}
