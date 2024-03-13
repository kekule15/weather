import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/utils/logger.dart';
import 'package:weather/viewmodel/base_vm.dart';

class UserLocationViewModel extends BaseViewModel {
  @override
  // ignore: overridden_fields
  final Ref ref;

  UserLocationViewModel(this.ref) : super(ref) {
    _determinePosition();
   // handlePermission();
  }

  Position? location;
  LocationPermission? permission;
  Future<Position?> getLocation() async {
    try {
      location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      notifyListeners();
      AppLogger.logg(
          "Lat ${location?.latitude}  .... long ${location?.longitude}");

      return location;
    } catch (e) {
      AppLogger.logg("Location error ${e.toString()}");
      return location;
    }
  }

  bool isLocationServiceEnabled = false;

  handlePermission() async {
    var status = await Permission.locationWhenInUse.request();
    status = await Permission.location.request();

    if (status.isGranted) {
      AppLogger.logg("grant");
      isLocationServiceEnabled = true;
      notifyListeners();
      await getLocation();
    } else if (status.isPermanentlyDenied) {
      AppLogger.logg("perm");
      openAppSettings();
    } else if (status.isDenied) {
      AppLogger.logg("denied");
      isLocationServiceEnabled = false;
      notifyListeners();
      openAppSettings();
      // _determinePosition();
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
