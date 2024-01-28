import 'package:cloud_firestore/cloud_firestore.dart';

class Favourite {
  String email;
  double latitude;
  double longitude;

  Favourite({
    required this.email,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'latitude': latitude,
        'longitude': longitude,
      };

  static Favourite fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;
    return Favourite(
      email: snapShot['email'],
      latitude: snapShot['latitude'],
      longitude: snapShot['longitude'],
    );
  }
}
