import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({
    required this.imageUrl,
    required this.title,
    required this.overview,
    required this.isDelete,
    required this.press,
    this.onDelete,
    super.key,
  });

  String imageUrl;
  String title;
  String overview;
  bool isDelete = false;
  final VoidCallback press;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Shadow color
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 2), // changes the shadow direction
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(7),
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          InkWell(
            onTap: press,
            child: Container(
              height: 90,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: press,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    isDelete
                        ? InkWell(
                            onTap: onDelete,
                            child: Icon(
                              Icons.delete,
                              size: 18,
                            ),
                          )
                        : SizedBox(width: 0),
                  ],
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: press,
                  child: Row(
                    children: [
                      for (var icon in [
                        Icons.coffee,
                        Icons.table_bar,
                        Icons.favorite_border_sharp,
                        Icons.add,
                      ])
                        Row(
                          children: [
                            Icon(
                              icon,
                              size: 18,
                            ),
                            SizedBox(width: 6), // Adjust the space as needed
                          ],
                        ),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: press,
                  child: Text(
                    overview,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                    softWrap: true,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
