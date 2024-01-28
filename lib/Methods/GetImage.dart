import 'package:image_picker/image_picker.dart';

Future<String> getLocationImage(ImageSource sourceImg) async {
  final imageFile = await ImagePicker().pickImage(source: sourceImg);

  if (imageFile != null) {
    return imageFile.path;
  } else {
    return "";
  }
}
