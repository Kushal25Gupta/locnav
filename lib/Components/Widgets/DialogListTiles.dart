import 'package:flutter/material.dart';

class DialogListTiles extends StatelessWidget {
  DialogListTiles({
    super.key,
    required this.text,
    required this.iconData,
    required this.press,
    this.color,
  });

  final String text;
  final IconData iconData;
  final VoidCallback press;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: Icon(
        iconData,
        size: 25,
        color: color ?? Colors.black54,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
