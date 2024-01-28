import 'package:geolocator/geolocator.dart';

Future<bool> requestPermission() async {
  try {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
