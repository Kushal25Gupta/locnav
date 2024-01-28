import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/Screens/AllLocationScreen.dart';
import 'package:location/Screens/FavourtieLocationScreen.dart';
import 'package:location/Screens/HomeScreen.dart';

import '../../Screens/MyLocationScreen.dart';

class CustomNavigationDrawer extends StatelessWidget {
  CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text('Kushal Gupta'),
      accountEmail: Text('Kushal2510Gupta@gmail.com'),
      currentAccountPicture: ClipOval(
        child: Image.network(
          'https://www.shutterstock.com/image-vector/young-smiling-man-avatar-brown-600nw-2261401207.jpg',
          width: 90,
          height: 90,
          fit: BoxFit.cover,
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.pexels.com/photos/1054218/pexels-photo-1054218.jpeg?cs=srgb&dl=pexels-stephan-seeber-1054218.jpg&fm=jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.not_listed_location_outlined),
          title: Text('Locations'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AllLocationScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.location_on_sharp),
          title: Text(
            'My Locations',
            style: TextStyle(
                color: Colors.black, fontFamily: 'BalsamiqSans_Regular'),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MyLocationScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('Favourite Locations'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FavouriteLocationScreen(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Setting'),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.help_outline_sharp),
          title: Text('Help'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Support'),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.phonelink_setup_sharp),
          title: InkWell(
            onTap: () async {
              await GoogleSignIn().signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text('Sign Out'),
          ),
        ),
      ],
    );
  }
}
