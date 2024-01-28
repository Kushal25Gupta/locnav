import 'package:flutter/material.dart';
import 'package:location/Screens/LocationBasedMapScreen.dart';

import '../Components/Utils.dart';
import '../Controllers/FavouriteController.dart';
import '../Methods/isFavourite.dart';

class DetailedLocation extends StatefulWidget {
  DetailedLocation({
    required this.imageUrl,
    required this.title,
    required this.overView,
    required this.landMark,
    required this.latitude,
    required this.longitude,
    super.key,
  });

  String imageUrl;
  String title;
  String overView;
  String landMark;
  double latitude;
  double longitude;

  @override
  State<DetailedLocation> createState() => _DetailedLocationState();
}

class _DetailedLocationState extends State<DetailedLocation> {
  bool isFavourite = false;
  @override
  void initState() {
    super.initState();
    initializeFavouriteState();
  }

  Future<void> initializeFavouriteState() async {
    bool fav = await isFavouriteExist(widget.latitude, widget.longitude);
    setState(() {
      isFavourite = fav;
    });
  }

  FavouriteController favouriteLocationController = FavouriteController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            margin: EdgeInsets.only(left: 20),
                            height: 45,
                            width: 45,
                            child: Icon(
                              Icons.arrow_back_sharp,
                              size: 25,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          margin: EdgeInsets.only(right: 20),
                          height: 45,
                          width: 45,
                          child: InkWell(
                            onTap: () async {
                              if (isFavourite) {
                                await favouriteLocationController
                                    .removeFavourite(
                                        widget.latitude, widget.longitude);
                                Utils()
                                    .successMessage("Removed from favourites");
                              } else {
                                await favouriteLocationController.addFavourite(
                                    widget.latitude, widget.longitude);
                                Utils().successMessage("Added to favourites");
                              }
                              setState(() {
                                isFavourite = !isFavourite;
                              });
                            },
                            child: Icon(
                              isFavourite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 25,
                              color: isFavourite
                                  ? Colors.redAccent
                                  : Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      softWrap: true,
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.landMark,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      softWrap: true,
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          child: Row(
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                size: 14,
                              ),
                              Text('12'),
                              Text(
                                '/hours  •',
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      widget.overView,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black45,
                        fontWeight: FontWeight.w300,
                      ),
                      softWrap: true,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LocationMap(
                                latitude: widget.latitude,
                                longitude: widget.longitude),
                          ),
                        );
                      },
                      child: Container(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
