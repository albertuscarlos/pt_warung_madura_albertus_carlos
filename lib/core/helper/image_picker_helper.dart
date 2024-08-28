import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker imagePicker;

  ImagePickerHelper({required this.imagePicker});

  Future<File?> getImage() async {
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      return File(selectedImage.path);
    } else {
      return null;
    }
  }
}
