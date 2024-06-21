import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService extends GetxController {
  static FirebaseStorageService get instance => Get.find();

  // final _firebaseStorage = FirebaseStorage.instance;
  Rx<File?> image = Rx<File?>(null);

  Future<XFile?> pickImage() async {
    try {
      final imagePicker =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagePicker == null) return null;

      final imageTemporary = File(imagePicker.path);
      image.value = imageTemporary;
    } catch (e) {
      // Show error message
      Get.snackbar(
        'Oh Snap!',
        e.toString(),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(
          Iconsax.warning_2,
          color: Colors.white,
        ),
      );
    }
    return null;
  }

  // Future<String?> getImage(String path, String? imgName) async {
  //   if (imgName == null) {
  //     return null;
  //   }
  //   try {
  //     var urlRef = FirebaseStorage.instance
  //         .ref()
  //         .child(path)
  //         .child(imgName.toLowerCase());
  //     var imgUrl = await urlRef.getDownloadURL();
  //     return imgUrl;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Upload local assets
  // Future<Uint8List> getImageDataFromAssets(String path) async {
  //   try {
  //     final byteData = await rootBundle.load(path);
  //     final imageData = byteData.buffer
  //         .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
  //     return imageData;
  //   } catch (e) {
  //     throw 'Error loading image data: $e';
  //   }
  // }

  // // Upload image using ImageData on cloud firebase storage
  // Future<String> uploadImageData(
  //     String path, Uint8List image, String name) async {
  //   try {
  //     final ref = _firebaseStorage.ref(path).child(name);
  //     await ref.putData(image);
  //     final url = await ref.getDownloadURL();
  //     return url;
  //   } catch (e) {
  //     if (e is FirebaseException) {
  //       throw 'Firebase Exception: ${e.message}';
  //     } else if (e is SocketException) {
  //       throw 'Network Error: ${e.message}';
  //     } else if (e is PlatformException) {
  //       throw 'Platform Exception: ${e.message}';
  //     } else {
  //       throw 'Something Went Wrong! Please try again.';
  //     }
  //   }
  // }

  // Upload image on cloud firebase storage
  // Future<String> uploadImageFile(String path, XFile image) async {
  //   try {
  //     final ref = _firebaseStorage.ref(path).child(image.name);
  //     await ref.putFile(File(image.path));
  //     final url = await ref.getDownloadURL();
  //     return url;
  //   } catch (e) {
  //     if (e is FirebaseException) {
  //       throw 'Firebase Exception: ${e.message}';
  //     } else if (e is SocketException) {
  //       throw 'Network Error: ${e.message}';
  //     } else if (e is PlatformException) {
  //       throw 'Platform Exception: ${e.message}';
  //     } else {
  //       throw 'Something Went Wrong! Please try again.';
  //     }
  //   }
  // }
}
