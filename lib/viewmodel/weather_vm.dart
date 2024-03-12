import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather/model/city_data_model.dart';
import 'package:weather/model/weather_response_model.dart';
import 'package:weather/providers/weather_data_provider.dart';
import 'package:weather/repository/weather_repository.dart';
import 'package:weather/utils/logger.dart';
import 'package:weather/utils/notify_me.dart';
import 'package:weather/utils/secrets.dart';
import 'package:weather/viewmodel/base_vm.dart';

class WeatherDataViewModel extends BaseViewModel {
  @override
  // ignore: overridden_fields
  final Ref ref;

  WeatherRepository? _weatherRepository;

  WeatherDataViewModel(this.ref) : super(ref) {
    _weatherRepository = ref.read(weatherRepositoryProvider);
    pullAllStoredCityList();
    getCityWeatherData(city: selectedCity.name);
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

  Future<void> pullAllStoredCityList() async {
    var box = await Hive.openBox('app');
    //storedCityList = [];
    isfetchLocalData = true;
    notifyListeners();

    final serviceBox = ValueNotifier(box.listenable(keys: [hiveKeyId]));

    List<dynamic> cityDataFromStorage =
        serviceBox.value.value.get(hiveKeyId) ?? [];

    if (cityDataFromStorage.isEmpty) {
    } else {
      storedCityList = [];
      cityDataFromStorage = serviceBox.value.value.get(hiveKeyId) ?? [];
      storedCityList =
          List<CityDataModel>.from(cityDataFromStorage.map((x) => (x)));
      isfetchLocalData = false;
      notifyListeners();
    }

    AppLogger.logg("Local data $storedCityList");
  }

  Future<void> selectCity({required CityDataModel city}) async {
    selectedCity = city;
    await getCityWeatherData(city: city.name);
    notifyListeners();
  }

  void addCityToList(
      {required CityDataModel item, required VoidCallback next}) async {
    var box = await Hive.openBox('app');

    final serviceBox = ValueNotifier(box.listenable(keys: [hiveKeyId]));

    List<dynamic> daaaa = serviceBox.value.value.get(hiveKeyId) ?? [];
    final list = List<CityDataModel>.from(daaaa.map((x) => (x)));

    // AppLogger.logg("list is not ${list}");
    list.add(item);
    notifyListeners();

    await box.put(hiveKeyId, list);
    await pullAllStoredCityList();
    next();
  }

  void removeCityFromStoredList(
      {required String name, required VoidCallback next}) async {
    var box = await Hive.openBox('app');
    if (name == "Lagos") {
      if (storedCityList.length == 1) {
        // storedCityList.removeWhere((element) => name == element.name);
        // notifyListeners();
        // AppLogger.logg("remove lagos");
      }
    } else {
      storedCityList.removeWhere((element) => name == element.name);
      notifyListeners();
    }

    await box.put(hiveKeyId, storedCityList);
    await pullAllStoredCityList();
    //
    fallBackToDefault(name: name);
  }

  void fallBackToDefault({required String name}) {
    if (selectedCity.name == name) {
      selectedCity =
          storedCityList.firstWhere((element) => element.name == "Lagos");
      notifyListeners();
      getCityWeatherData(city: "Lagos");
    } else {}
  }

  bool isLoadingWeather = false;
  List<ListElement>? list = [];
  Future getCityWeatherData({
    required String city,
  }) async {
    isLoadingWeather = true;
    notifyListeners();
    final res = await _weatherRepository?.getCityWeatherData(
        city: city, units: "metric", appId: Secrets.wAPIKEY);
    if (res != null) {
      list = [];
      AppLogger.logg("response $res");
      isLoadingWeather = false;
      list = res.list;
      notifyListeners();
    } else {
      NotifyMe.showAlert("error");
      isLoadingWeather = false;
      notifyListeners();
    }
  }
}
