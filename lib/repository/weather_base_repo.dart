import 'package:weather/model/user_location_weather_response_model.dart';
import 'package:weather/model/weather_response_model.dart';

abstract class BaseWeatherRepository {
  Future<WeatherResponseModel?> getCityWeatherData(
      {required String city, required String units, required String appId});

       Future<UserLocationResponseModel?> getWeatherByCoordinate(
      {required double lat, required double lon, required String appId});
}
