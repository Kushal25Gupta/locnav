import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/Components/Utils.dart';
import 'package:location/Methods/DoesImageExists.dart';
import 'package:location/Methods/isFavourite.dart';
import '../../Controllers/FavouriteController.dart';
import '../../Methods/GetImage.dart';
import '../../Screens/Upload_Image_Form.dart';
import 'DialogListTiles.dart';

class AddImageDialog extends StatefulWidget {
  AddImageDialog({required this.latitude, required this.longitude, super.key});
  double latitude;
  double longitude;

  @override
  State<AddImageDialog> createState() => _AddImageDialogState();
}

class _AddImageDialogState extends State<AddImageDialog> {
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
    return Dialog(
      child: Container(
        height: 225,
        child: Column(
          children: [
            DialogListTiles(
              text: 'Gallery',
              iconData: Icons.photo,
              press: () async {
                bool isImageExist =
                    await doesImageExist(widget.latitude, widget.longitude);
                if (isImageExist) {
                  Utils().errorMessage('This location has a image');
                } else {
                  String imagepath =
                      await getLocationImage(ImageSource.gallery);
                  if (imagepath.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UploadImageForm(
                          imagePath: imagepath,
                          latitude: widget.latitude,
                          longitude: widget.longitude,
                        ),
                      ),
                    );
                  } else {
                    Utils().errorMessage("Please choose a image");
                    Navigator.pop(context);
                  }
                }
              },
            ),
            DialogListTiles(
              text: 'Camera',
              iconData: Icons.camera_alt_rounded,
              press: () async {
                bool isImageExist =
                    await doesImageExist(widget.latitude, widget.longitude);
                if (isImageExist) {
                  Utils().errorMessage('This location has a image');
                } else {
                  String imagepath = await getLocationImage(ImageSource.camera);
                  if (imagepath.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UploadImageForm(
                          imagePath: imagepath,
                          latitude: widget.latitude,
                          longitude: widget.longitude,
                        ),
                      ),
                    );
                  } else {
                    Utils().errorMessage("Please click a photo");
                    Navigator.pop(context);
                  }
                }
              },
            ),
            DialogListTiles(
              text: isFavourite ? "Remove Favourite" : "Favourite",
              iconData: isFavourite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              press: () async {
                if (isFavourite) {
                  await favouriteLocationController.removeFavourite(
                      widget.latitude, widget.longitude);
                  Utils().successMessage("Removed from favourites");
                } else {
                  await favouriteLocationController.addFavourite(
                      widget.latitude, widget.longitude);
                  Utils().successMessage("Added to favourites");
                }

                setState(() {
                  isFavourite = !isFavourite;
                });

                Navigator.pop(context);
              },
              color: isFavourite ? Colors.redAccent : Colors.black54,
            ),
            DialogListTiles(
              text: 'Cancel',
              iconData: Icons.cancel,
              press: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
