import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    super.key,
    required this.press,
    required this.location,
  });

  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: Icon(Icons.location_pin),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: Colors.grey.shade100,
        ),
      ],
    );
  }
}
