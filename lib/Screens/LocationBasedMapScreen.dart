import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatelessWidget {
  LocationMap({required this.latitude, required this.longitude, super.key});

  double latitude;
  double longitude;
  @override
  Widget build(BuildContext context) {
    LatLng location = LatLng(latitude, longitude);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: location,
              zoom: 18,
            ),
            markers: {
              Marker(
                markerId: MarkerId('_newLocation'),
                icon: BitmapDescriptor.defaultMarker,
                position: location,
              ),
            },
          ),
          Container(
            margin: EdgeInsets.only(
              left: 25,
              top: MediaQuery.of(context).padding.top + 25,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes the shadow direction
                ),
              ],
            ),
            height: 50,
            width: 50,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black54,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
