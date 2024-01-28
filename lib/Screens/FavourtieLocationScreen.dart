import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/Components/Widgets/LocationListViewListTile.dart';
import 'package:location/Components/Widgets/NavigationDrawer.dart';
import 'package:location/Screens/LocationBasedMapScreen.dart';
import '../Components/Utils.dart';
import '../Controllers/FavouriteController.dart';
import '../Controllers/FavouriteLocationScreenController.dart';

class FavouriteLocationScreen extends StatelessWidget {
  FavouriteLocationScreen({super.key});

  FavouriteController favouriteController = FavouriteController();
  final FavouriteLocationController favouriteLocationController =
      Get.put(FavouriteLocationController());

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
          'Favourite Locations',
          style: TextStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel_outlined),
          )
        ],
      ),
      body: Obx(() {
        if (favouriteLocationController.favouriteLocationList.isEmpty) {
          return const Center(
            child: Text(
              'No Favourites Location Available',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
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
                  itemCount:
                      favouriteLocationController.favouriteLocationList.length,
                  itemBuilder: (context, index) {
                    final data = favouriteLocationController
                        .favouriteLocationList[index];
                    return CustomListTile(
                      imageUrl:
                          'https://i.ytimg.com/vi/zVgZ0PGPhzU/maxresdefault.jpg',
                      title: '${index + 1} Location',
                      overview: "",
                      isDelete: true,
                      press: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LocationMap(
                              latitude: data.latitude,
                              longitude: data.longitude,
                            ),
                          ),
                        );
                      },
                      onDelete: () async {
                        await favouriteController.removeFavourite(
                            data.latitude, data.longitude);
                        Utils().successMessage("Removed from favourites");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
