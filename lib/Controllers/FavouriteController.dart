import 'package:get/get.dart';
import 'package:location/Components/Utils.dart';
import 'package:location/Models/Favourite.dart';

import '../Global.dart';

class FavouriteController extends GetxController {
  removeFavourite(double latitude, double longitude) async {
    try {
      var favouriteDoc = await fireStore
          .collection('Users')
          .doc(userEmail)
          .collection('Favourite')
          .where('latitude', isEqualTo: latitude)
          .where('longitude', isEqualTo: longitude)
          .get();

      if (favouriteDoc.docs.isNotEmpty) {
        // Assuming there is only one matching document, delete it
        await favouriteDoc.docs.first.reference.delete();
      }
    } catch (e) {
      Utils().errorMessage("Technical issue, Please try again later");
    }
  }

  addFavourite(double latitude, double longitude) async {
    try {
      var allDocs = await fireStore
          .collection('Users')
          .doc(userEmail)
          .collection('Favourite')
          .get();
      int len = allDocs.docs.length;
      Favourite favourite =
          Favourite(email: userEmail, latitude: latitude, longitude: longitude);
      await fireStore
          .collection('Users')
          .doc(userEmail)
          .collection('Favourite')
          .doc('Favourite $len')
          .set(favourite.toJson());
    } catch (e) {
      Utils().errorMessage(e.toString());
    }
  }
}
