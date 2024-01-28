import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/Components/Utils.dart';
import 'package:location/Components/Widgets/inputTextWidget.dart';
import 'package:location/Controllers/UploadImageController.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageForm extends StatefulWidget {
  UploadImageForm(
      {required this.latitude,
      required this.longitude,
      required this.imagePath,
      super.key});

  final String imagePath;
  double latitude;
  double longitude;

  @override
  State<UploadImageForm> createState() => _UploadImageFormState();
}

class _UploadImageFormState extends State<UploadImageForm> {
  bool _showLoader = false;
  late File imageFile;
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController landmarkEditingController = TextEditingController();
  TextEditingController overviewEditingController = TextEditingController();
  UploadImageController uploadImageController =
      Get.put(UploadImageController());

  @override
  Widget build(BuildContext context) {
    imageFile = File(widget.imagePath);
    LatLng location = LatLng(widget.latitude, widget.longitude);
    return ModalProgressHUD(
      inAsyncCall: _showLoader,
      child: Scaffold(
        backgroundColor: ThemeData.dark().cardColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: InputTextWidget(
                  textEditingController: titleEditingController,
                  labelString: "Title",
                  iconData: Icons.title,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: InputTextWidget(
                  textEditingController: landmarkEditingController,
                  labelString: "Landmark",
                  iconData: Icons.near_me,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: InputTextWidget(
                  textEditingController: overviewEditingController,
                  labelString: "Overview",
                  iconData: Icons.description,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    _showLoader = !_showLoader;
                  });
                  if (titleEditingController.text.isNotEmpty &&
                      landmarkEditingController.text.isNotEmpty &&
                      overviewEditingController.text.isNotEmpty) {
                    try {
                      await uploadImageController.uploadImage(
                        titleEditingController.text,
                        landmarkEditingController.text,
                        overviewEditingController.text,
                        widget.imagePath,
                        location,
                        context,
                      );
                      Utils().successMessage("Image Uploaded Successfully");
                      Navigator.pop(context);
                    } catch (e) {
                      Navigator.pop(context);
                      Utils().errorMessage(e.toString());
                    }
                  } else {
                    Utils().errorMessage('Please fill all the details');
                    setState(() {
                      _showLoader = false;
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 38,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Upload Now",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
