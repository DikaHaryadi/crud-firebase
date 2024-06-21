import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService extends GetxController {
  static FirebaseStorageService get instance => Get.find();

  // final _firebaseStorage = FirebaseStorage.instance;
  Rx<File?> image = Rx<File?>(null);
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

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

  Future<String> uploadImage(File file) async {
    try {
      // Nama file unik menggunakan timestamp
      final fileName =
          'user_photos/${DateTime.now().millisecondsSinceEpoch}.png';
      final ref = _firebaseStorage.ref().child(fileName);
      final uploadTask = await ref.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
