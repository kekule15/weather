import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather/viewmodel/weather_vm.dart';

final weatherDataProvider = ChangeNotifierProvider<WeatherDataViewModel>(
    (ref) => WeatherDataViewModel(ref));