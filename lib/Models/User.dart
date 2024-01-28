import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class GoogleUser {
  String email;
  String username;
  double latitude;
  double longitude;
  String profilephoto;

  GoogleUser({
    required this.email,
    required this.username,
    required this.latitude,
    required this.longitude,
    required this.profilephoto,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'latitude': latitude,
        'longitude': longitude,
        'profilephoto': profilephoto
      };

  static GoogleUser fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return GoogleUser(
      email: snap['email'],
      username: snap['username'],
      latitude: snap['latitude'],
      longitude: snap['longitude'],
      profilephoto: snap['profilephoto'],
    );
  }
}
