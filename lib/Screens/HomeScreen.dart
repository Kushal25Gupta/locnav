import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/Components/Widgets/AddImagePopUpDailog.dart';
import 'package:location/Global.dart';
import 'package:location/Components/Widgets/NavigationDrawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/Screens/SearchLocation.dart';

import '../Controllers/ProfileController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  late final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: profileController,
      builder: (controller) {
        if (controller.userData.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        double latitude = controller.userData['latitude'];
        double longitude = controller.userData['longitude'];
        userLocation = LatLng(latitude, longitude);
        return Scaffold(
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: userLocation,
                  zoom: 18,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('_currentPosition'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: userLocation,
                    infoWindow: InfoWindow(
                      title: 'Add Images',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddImageDialog(
                              latitude: latitude,
                              longitude: longitude,
                            );
                          },
                        );
                      },
                    ),
                  ),
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  top: MediaQuery.of(context).padding.top + 25,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset:
                                Offset(0, 2), // changes the shadow direction
                          ),
                        ],
                      ),
                      height: 50,
                      width: 50,
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.5), // Shadow color
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 2), // changes the shadow direction
                            ),
                          ],
                        ),
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: 50,
                        child: ListTile(
                          dense: true,
                          horizontalTitleGap: 0,
                          contentPadding: EdgeInsets.only(left: 10, top: 2),
                          leading: Icon(Icons.search),
                          title: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SearchLocationScreen(
                                    completer: _controller,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Search Location',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddImageDialog(
                                      latitude: latitude,
                                      longitude: longitude,
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.add_photo_alternate_sharp)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          drawer: CustomNavigationDrawer(),
        );
      },
    );
  }
}
