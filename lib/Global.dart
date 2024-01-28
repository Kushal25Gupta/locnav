import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userEmail = "";
final firebaseAuth = FirebaseAuth.instance;
final fireStore = FirebaseFirestore.instance;
final firebaseStorage = FirebaseStorage.instance;
String id = "";
double deviceHeight = 0;
double deviceWidth = 0;
bool givenLocation = false;
Position userPosition = Position(
  latitude: 37.7749, // Default latitude (e.g., San Francisco)
  longitude: -122.4194, // Default longitude
  timestamp: DateTime.now(), // Placeholder timestamp
  accuracy: 0, // Placeholder accuracy
  altitude: 0, // Placeholder altitude
  speed: 0, // Placeholder speed
  speedAccuracy: 0, // Placeholder speed accuracy
  heading: 0,
  altitudeAccuracy: 0,
  headingAccuracy: 0, // Placeholder heading
);
LatLng userLocation = LatLng(userPosition.latitude, userPosition.longitude);
