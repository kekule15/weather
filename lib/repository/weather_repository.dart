import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather/http/api_manager.dart';
import 'package:weather/model/user_location_weather_response_model.dart';
import 'package:weather/model/weather_response_model.dart';

class WeatherRepository extends ApiManager {
  final Ref reader;
  WeatherRepository(this.reader) : super(reader);
  final getCityWeatherDataRoute = '/data/2.5/forecast/daily?';
  final getWeatherByCoodinateRoute = '/data/2.5/weather?';

  Future<WeatherResponseModel?> getCityWeatherData(
      {required String city,
      required String units,
      required String appId}) async {
    final params = {
      "q": city,
      "appid": appId,
      "units": units,
    };

    final response = await getHttp(getCityWeatherDataRoute, params: params);
    var data = response.data;

    if (response.statusCode == 200) {
      return WeatherResponseModel.fromJson(data);
    } else {
      return null;
    }
  }

  Future<UserLocationResponseModel?> getWeatherByCoordinate(
      {required double lat, required double lon, required String appId}) async {
    final params = {
      "lat": lat,
      "lon": lon,
      "appid": appId,
    };

    final response = await getHttp(getWeatherByCoodinateRoute, params: params);
    var data = response.data;

    if (response.statusCode == 200) {
      return UserLocationResponseModel.fromJson(data);
    } else {
      return null;
    }
  }
}
