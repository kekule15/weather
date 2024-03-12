

import 'package:weather/model/weather_response_model.dart';

abstract class BaseWeatherRepository {

  Future<WeatherResponseModel?> getCityWeatherData({required String city, required String units, required String appId});


}
