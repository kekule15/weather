import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/utils/logger.dart';
import 'package:weather/viewmodel/base_vm.dart';

class UserLocationViewModel extends BaseViewModel {
  @override
  // ignore: overridden_fields
  final Ref ref;

  UserLocationViewModel(this.ref) : super(ref) {
    _determinePosition();
  }

  Position? location;
  LocationPermission? permission;
 Future getLocation() async {
    try {
      if (permission == LocationPermission.denied) {
        AppLogger.logg("Permission denied");
        await _determinePosition();
      } else {
        AppLogger.logg("Permission Not denied");
        location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        notifyListeners();
        AppLogger.logg(
            "Lat ${location?.latitude}  .... long ${location?.longitude}");
      }
    } catch (e) {
      AppLogger.logg("Location error ${e.toString()}");
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    notifyListeners();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    location = await Geolocator.getCurrentPosition();
    notifyListeners();
    return location!;
  }
}
