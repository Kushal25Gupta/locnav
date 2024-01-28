import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../Global.dart';
import '../Models/Favourite.dart';

class FavouriteLocationController extends GetxController {
  final Rx<List<Favourite>> _favouriteLocationList = Rx<List<Favourite>>([]);
  List<Favourite> get favouriteLocationList => _favouriteLocationList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _favouriteLocationList.bindStream(fireStore
        .collection('Users')
        .doc(userEmail)
        .collection('Favourite')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Favourite> retVal = [];
      for (var element in query.docs) {
        retVal.add(Favourite.fromSnap(element));
      }
      return retVal;
    }));
  }
}
