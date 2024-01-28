import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/Components/Widgets/NavigationDrawer.dart';
import 'package:location/Controllers/AllLocationController.dart';
import '../Components/Widgets/LocationListViewListTile.dart';
import 'DetailedLocation.dart';

class AllLocationScreen extends StatelessWidget {
  AllLocationScreen({super.key});

  final AllLocationController allLocationController =
      Get.put(AllLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomNavigationDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Icon(
                Icons.menu,
                size: 23,
                color: Colors.white,
              ),
              // Set your desired icon color here
            );
          },
        ),
        title: Text(
          'Location Explorer',
          style: TextStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel_outlined),
          )
        ],
      ),
      body: Obx(
        () {
          if (allLocationController.locationList.isEmpty) {
            return const Center(
              child: Text(
                'No Location List Available',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), // Shadow color
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes the shadow direction
                      ),
                    ],
                  ),
                  height: 45,
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: Icon(Icons.search),
                    title: Text(
                      'Search Location',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: allLocationController.locationList.length,
                      itemBuilder: (context, index) {
                        final data = allLocationController.locationList[index];
                        return CustomListTile(
                          imageUrl: data.image,
                          title: data.title,
                          overview: data.overview,
                          isDelete: false,
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailedLocation(
                                  imageUrl: data.image,
                                  title: data.title,
                                  overView: data.overview,
                                  landMark: data.locationLandmark,
                                  latitude: data.latitude,
                                  longitude: data.longitude,
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
