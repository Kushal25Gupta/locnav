import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:location/Models/LocationDetail.dart';

import '../Global.dart';

class AllLocationController extends GetxController {
  final Rx<List<LocationDetail>> _locationList = Rx<List<LocationDetail>>([]);
  List<LocationDetail> get locationList => _locationList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _locationList.bindStream(
        fireStore.collection('Location').snapshots().map((QuerySnapshot query) {
      List<LocationDetail> retVal = [];
      for (var element in query.docs) {
        retVal.add(LocationDetail.fromSnap(element));
      }
      return retVal;
    }));
  }
}
