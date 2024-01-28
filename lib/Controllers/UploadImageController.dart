import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:location/Models/LocationDetail.dart';
import 'package:location/Global.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class UploadImageController extends GetxController {
  Future<String> _uploadImageToStorage(String id, String imagePath) async {
    Reference ref = firebaseStorage.ref().child("LocationImages").child(id);
    UploadTask uploadTask = ref.putFile(File(imagePath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadImage(String title, String landMark, String overView, String imagePath,
      LatLng location, BuildContext context) async {
    try {
      var allDocs = await fireStore.collection('Location').get();
      int len = allDocs.docs.length;
      String imageUrl =
          await _uploadImageToStorage('LocationImage $len', imagePath);
      double latitude = location.latitude;
      double longitude = location.longitude;

      LocationDetail locationDetail = LocationDetail(
        email: userEmail,
        image: imageUrl,
        title: title,
        overview: overView,
        latitude: latitude,
        longitude: longitude,
        locationLandmark: landMark,
      );

      await fireStore
          .collection('Location')
          .doc('Location $len')
          .set(locationDetail.toJson());
      Navigator.pop(context);
    } catch (e) {
      print('Error uploading data to Firestore: $e');
    }
  }
}
