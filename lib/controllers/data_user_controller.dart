import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pranamas/controllers/get_data_user_controller.dart';
import 'package:pranamas/models/data_user_model.dart';
import 'package:pranamas/repository/data_user_repo.dart';
import 'package:pranamas/screens/rootpage.dart';
import 'package:pranamas/utils/animation_loader.dart';
import 'package:pranamas/utils/firebase_storage_service.dart';

import '../users/network_manager.dart';

class DataUserController extends GetxController {
  final userNameController = TextEditingController();
  final password = TextEditingController();
  final namaUser = TextEditingController();
  final umurController = TextEditingController();
  final agama = 'Islam'.obs;
  final jenisKelamin = ''.obs;
  final pendidikan = 'SD'.obs;
  final alamat = TextEditingController();

  final dataUserRepo =
      Get.put(DataUserRepository()); // Pastikan ini digunakan secara konsisten
  GlobalKey<FormState> dataUserFormKey = GlobalKey<FormState>();
  Rx<DataUserModel> dataUserEmpty = DataUserModel.empty().obs;
  final hidePassword = true.obs;

  Future<String?> sendDataUserContent() async {
    try {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => const PopScope(
          canPop: false,
          child: AnimationLoader(
            text: 'Processing...',
            animation: 'assets/animations/141594-animation-of-docer.json',
            showAction: false,
          ),
        ),
      );

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Navigator.of(Get.overlayContext!).pop();
        return null;
      }

      // Form validation
      if (!dataUserFormKey.currentState!.validate()) {
        Navigator.of(Get.overlayContext!).pop();
        return null;
      }

      if (FirebaseStorageService.instance.image.value == null) {
        Navigator.of(Get.overlayContext!).pop();
        return null;
      }

      // ini image pick
      final xFile = XFile(FirebaseStorageService.instance.image.value!.path);

      final imgUrl = await dataUserRepo.uploadImage('Content/DataUser/', xFile);

      dataUserEmpty.value.photoUser = imgUrl;

      // save post data fammily into cloud firestore
      final newdataUserEmpty = DataUserModel(
        photoUser: dataUserEmpty.value.photoUser,
        userName: userNameController.text.trim(),
        password: password.text.trim(),
        namaUser: namaUser.text.trim(),
        umur: umurController.text.trim(),
        agama: agama.value,
        jenisKelamin: jenisKelamin.value,
        pendidikan: pendidikan.value,
        alamat: alamat.text.trim(),
      );

      // post data
      await dataUserRepo.savedataUserModelContent(newdataUserEmpty);

      // Perbarui state
      update();

      // Remove loader
      Navigator.of(Get.overlayContext!).pop();

      Get.snackbar(
        'Congratulations',
        'Your dataUserEmpty content has been created!',
        maxWidth: 600,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.blueAccent,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Iconsax.check, color: Colors.white),
      );

      // Navigate to home
      Get.off(() => const RootPage());
      GetDataUserController.instance.fetchData();

      return null;
    } catch (e) {
      Navigator.of(Get.overlayContext!).pop();
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
      print('animal error: $e');
      return null;
    }
  }
}
