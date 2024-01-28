import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> doesImageExist(double latitude, double longitude) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Location')
      .where('latitude', isEqualTo: latitude)
      .where('longitude', isEqualTo: longitude)
      .get();

  return querySnapshot.docs.isNotEmpty;
}
