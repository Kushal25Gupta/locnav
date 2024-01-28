import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/Global.dart';

Future<bool> isFavouriteExist(double latitude, double longitude) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(userEmail)
      .collection('Favourite')
      .where('latitude', isEqualTo: latitude)
      .where('longitude', isEqualTo: longitude)
      .get();

  return querySnapshot.docs.isNotEmpty;
}
