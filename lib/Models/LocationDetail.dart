import 'package:cloud_firestore/cloud_firestore.dart';

class LocationDetail {
  String email;
  String image;
  String title;
  String overview;
  double latitude;
  double longitude;
  String locationLandmark;

  LocationDetail({
    required this.email,
    required this.image,
    required this.title,
    required this.overview,
    required this.latitude,
    required this.longitude,
    required this.locationLandmark,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'image': image,
        'title': title,
        'overview': overview,
        'latitude': latitude,
        'longitude': longitude,
        'locationLandmark': locationLandmark,
      };

  static LocationDetail fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return LocationDetail(
      email: snapshot['email'],
      image: snapshot['image'],
      title: snapshot['title'],
      overview: snapshot['overview'],
      latitude: snapshot['latitude'],
      longitude: snapshot['longitude'],
      locationLandmark: snapshot['locationLandmark'],
    );
  }
}
