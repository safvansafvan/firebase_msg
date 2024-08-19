import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileController extends GetxController {
  File? selectedGalleryImage;
  File? selectedCameraImage;

  Future<void> pickGalleryImage() async {
    if (selectedGalleryImage != null) {
      selectedGalleryImage = null;
    }
    if (selectedCameraImage != null) {
      selectedCameraImage = null;
    }
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      selectedGalleryImage = photoTemp;
    }
    update();
  }

  Future<void> takeCameraImage() async {
    if (selectedGalleryImage != null) {
      selectedGalleryImage = null;
    }
    if (selectedCameraImage != null) {
      selectedCameraImage = null;
    }
    final photo = await ImagePicker().pickImage(source: ImageSource.camera);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      selectedCameraImage = photoTemp;
    }
    update();
  }
}
