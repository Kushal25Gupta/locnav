import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/Global.dart';
import '../Components/Utils.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _userData = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get userData => _userData.value;

  getUserData() async {
    try {
      final userDoc = await fireStore.collection('Users').doc(userEmail).get();
      final userData = userDoc.data()! as dynamic;
      final username = userData['username'];
      final profilePhoto = userData['profilephoto'];
      double latitude = userData['latitude'] as double;
      double longitude = userData['longitude'] as double;

      _userData.value = {
        'username': username,
        'profilephoto': profilePhoto,
        'latitude': latitude,
        'longitude': longitude,
      };
    } catch (e) {
      print('Error fetching user data: $e');
    }
    update();
  }

  updateLocation(double latitude, double longitude) async {
    try {
      await fireStore.collection('Users').doc(userEmail).update({
        'latitude': latitude,
        'longitude': longitude,
      });

      _userData.value.update('latitude', (value) => latitude);
      _userData.value.update('longitude', (value) => longitude);
    } catch (e) {
      Utils().errorMessage(e.toString());
    }
  }
}
