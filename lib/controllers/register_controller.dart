import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pranamas/controllers/auth_controller.dart';
import 'package:pranamas/models/user_model.dart';
import 'package:pranamas/repository/user_repo.dart';
import 'package:pranamas/users/network_manager.dart';
import 'package:pranamas/users/verify_email.dart';
import 'package:pranamas/utils/animation_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final privacyPolicy = true.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
    try {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => const PopScope(
          canPop: false,
          child: AnimationLoader(
            text: 'Kami sedang memproses informasi anda ...',
            animation: 'assets/animations/141594-animation-of-docer.json',
            showAction: false,
          ),
        ),
      );

      // Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      // Privacy policy check
      if (!privacyPolicy.value) {
        Get.snackbar(
          'Accept Kebijakan Privasi',
          'In order to create an account, you must read and accept the Kebijakan Privasi & Terms of Use',
          isDismissible: true,
          shouldIconPulse: true,
          colorText: Colors.white,
          backgroundColor: Colors.blue,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(20),
          icon: const Icon(
            Iconsax.warning_2,
            color: Colors.white,
          ),
        );
        Navigator.of(Get.overlayContext!).pop();
        return;
      }

      // Register user in Firebase Auth and save user data in Firebase Firestore
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      // get token

      // Save Auth user data in Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: userName.text.trim(),
        email: email.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove loader
      Navigator.of(Get.overlayContext!).pop();

      Get.snackbar(
        'Selamat',
        'Your account has been created! Verify email to continue.',
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

      // Navigate to verify email
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
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
    }
  }
}
