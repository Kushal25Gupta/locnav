import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/Components/Utils.dart';
import 'package:location/Components/Widgets/LocationListTile.dart';
import 'package:location/Controllers/ProfileController.dart';
import 'package:location/Global.dart';
import 'package:location/Methods/RequestPermission.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({required this.completer, super.key});
  final Completer<GoogleMapController> completer;
  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  TextEditingController textEditingController = TextEditingController();
  late final ProfileController profileController = Get.put(ProfileController());
  var uuid = Uuid();
  String _sessionToken = "12345";
  List<dynamic> _placesList = [];
  bool _showLoader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken == uuid.v4();
      });
    }

    getSuggestion(textEditingController.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyADIbFmsEVo2eN7i5TCsWmwDgHwkX_Ip5o";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _showLoader,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () async {
              setState(() {
                _showLoader = !_showLoader;
              });
              bool _givenPermission = await requestPermission();
              givenLocation = _givenPermission;
              if (_givenPermission) {
                Position newPosition = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.bestForNavigation);
                double latitude = newPosition.latitude;
                double longitude = newPosition.longitude;
                await profileController.updateLocation(latitude, longitude);
                GoogleMapController controller = await widget.completer.future;
                await controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      zoom: 18,
                      target: LatLng(latitude, longitude),
                    ),
                  ),
                );
                Navigator.of(context).pop();
              } else {
                Utils().errorMessage("Please give location permission");
                Navigator.of(context).pop();
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 15),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Icon(
                  Icons.near_me,
                  size: 20,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'Set Location',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF0D0D0E),
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 15, top: 15),
              child: CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 20,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextFormField(
                cursorColor: Colors.teal,
                controller: textEditingController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search your location",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Icon(
                      Icons.location_on_sharp,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 4,
              thickness: 4,
              color: Colors.grey.shade100,
            ),
            InkWell(
              onTap: () async {
                setState(() => _showLoader = true);
                bool _givenPermission = await requestPermission();
                givenLocation = _givenPermission;
                if (_givenPermission) {
                  Position newPosition = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.bestForNavigation);
                  double latitude = newPosition.latitude;
                  double longitude = newPosition.longitude;
                  await profileController.updateLocation(latitude, longitude);

                  GoogleMapController controller =
                      await widget.completer.future;

                  controller.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 18,
                        target: LatLng(latitude, longitude),
                      ),
                    ),
                  );

                  Navigator.of(context).pop();
                } else {
                  Utils().errorMessage("Please give location permission");
                  Navigator.of(context).pop();
                }
                setState(() => _showLoader = false);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.near_me),
                    SizedBox(width: 5),
                    Text('Use My Current Location'),
                  ],
                ),
              ),
            ),
            Divider(
              height: 4,
              thickness: 4,
              color: Colors.grey.shade100,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (context, index) => LocationListTile(
                  press: () async {
                    List<Location> locations = await locationFromAddress(
                        _placesList[index]['description']);
                    double latitude = locations.last.latitude;
                    double longitude = locations.last.longitude;
                    await profileController.updateLocation(latitude, longitude);
                    GoogleMapController controller =
                        await widget.completer.future;
                    await controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          zoom: 18,
                          target: LatLng(latitude, longitude),
                        ),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  location: _placesList[index]['description'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
