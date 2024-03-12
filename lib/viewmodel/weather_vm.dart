import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/model/city_data_model.dart';
import 'package:weather/utils/logger.dart';
import 'package:weather/viewmodel/base_vm.dart';
//import 'package:get_storage/get_storage.dart';

class WeatherDataViewModel extends BaseViewModel {
  @override
  // ignore: overridden_fields
  final Ref ref;

  WeatherDataViewModel(this.ref) : super(ref) {
    //pullAndPushCityList();
  }

  var hiveKeyId = "weather";

  CityDataModel selectedCity =
      CityDataModel(name: "Lagos", lat: 6.4550, long: 3.3841);

  List<CityDataModel> storedCityList = [
    CityDataModel(name: "Lagos", lat: 6.4550, long: 3.3841),
    CityDataModel(name: "Abuja", lat: 6.4550, long: 3.3841),
    CityDataModel(name: "Port Harcourt", lat: 4.8242, long: 7.0336),
  ];

  List<CityDataModel> cityDataList = [
    CityDataModel(name: "Lagos", lat: 6.4550, long: 3.3841),
    CityDataModel(name: "Abuja", lat: 6.4550, long: 3.3841),
    CityDataModel(name: "Port Harcourt", lat: 4.8242, long: 7.0336),
    CityDataModel(name: "Kano", lat: 12.0000, long: 8.5167),
    CityDataModel(name: "Ibadan", lat: 7.3964, long: 3.9167),
    CityDataModel(name: "Aba", lat: 5.1167, long: 7.3667),
    CityDataModel(name: "Onitsha", lat: 6.1667, long: 6.7833),
    CityDataModel(name: "Maiduguri", lat: 11.8333, long: 13.1500),
    CityDataModel(name: "Benin City", lat: 6.3333, long: 5.6222),
    CityDataModel(name: "Owerri", lat: 5.4833, long: 7.0333),
    CityDataModel(name: "Ikeja", lat: 6.6186, long: 3.3426),
    CityDataModel(name: "Sokoto", lat: 13.0622, long: 5.2339),
    CityDataModel(name: "Bida", lat: 9.0804, long: 6.0100),
    CityDataModel(name: "Kpor", lat: 4.6526, long: 7.2840),
    CityDataModel(name: "Effurun", lat: 5.5563, long: 5.7846),
    CityDataModel(name: "Egbeda", lat: 7.3772, long: 4.0498),
  ];

  bool isfetchLocalData = false;

  Future<void> pullAndPushCityList() async {
    var box = await Hive.openBox('app');
    //storedCityList = [];
    isfetchLocalData = true;
    notifyListeners();

    final shopItemBox = ValueNotifier(box.listenable(keys: [hiveKeyId]));

    List<dynamic> cityDataFromStorage =
        shopItemBox.value.value.get(hiveKeyId) ?? [];

    if (cityDataFromStorage.isEmpty) {
      var newData = cityDataList;
      await box.put(hiveKeyId, newData);
      storedCityList = newData;
      isfetchLocalData = false;
      notifyListeners();
    } else {
      storedCityList = [];
      cityDataFromStorage = shopItemBox.value.value.get(hiveKeyId) ?? [];
      storedCityList =
          List<CityDataModel>.from(cityDataFromStorage.map((x) => (x)));
      isfetchLocalData = false;
      notifyListeners();
    }
    AppLogger.logg("Local data $storedCityList");
  }

  void selectCity({required CityDataModel city}) {
    selectedCity = city;
    notifyListeners();
  }
}
