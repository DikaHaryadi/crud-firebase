import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pranamas/controllers/sign_up_controller.dart';
import 'package:pranamas/models/agama_model.dart';
import 'package:pranamas/repository/agama_repo.dart';
import 'package:pranamas/users/network_manager.dart';

class AgamaController extends GetxController {
  RxList<AgamaModel> agamaModel = <AgamaModel>[].obs;
  final isLoadingAgama = RxBool(false);
  final agama = ''.obs;
  final errorMessage = ''.obs;
  final agamaRepo = Get.put(AgamaRepository());

  @override
  void onInit() {
    super.onInit();
    fetchDataAgama();
  }

  bool validateAgama() {
    if (agama.value.isEmpty) {
      errorMessage.value = "Please select a religion";
      return false;
    }
    errorMessage.value = "";
    return true;
  }

  Future<String?> sendAgamaContent() async {
    if (!await checkConnectivityAndShowDialog()) {
      return null;
    }
    if (!validateAgama()) {
      hideDialog();
      return null;
    }
    try {
      final newdataAgama = AgamaModel(agama: agama.value, agamaId: '');
      final docId = await agamaRepo.saveAgamaContent(newdataAgama);
      newdataAgama.agamaId = docId;
      agamaModel.add(newdataAgama);
      agama.value = '';
      update();
      showSuccessSnackbar(
          'Congratulations', 'Your Agama content has been created!');
    } catch (e) {
      showErrorSnackbar('Oh Snap!', e.toString());
    }
    hideDialog();
    return null;
  }

  Future<void> fetchDataAgama() async {
    isLoadingAgama.value = true;
    try {
      final dataUsers = await agamaRepo.fetchDataAgama();
      agamaModel.assignAll(dataUsers);
    } catch (e) {
      agamaModel.assignAll([]);
      showErrorSnackbar('Data Fetch Error', 'Failed to fetch data: $e');
    } finally {
      isLoadingAgama.value = false;
    }
  }

  Future<void> deleteAgamaUser(AgamaModel agama) async {
    try {
      await agamaRepo.deleteAgama(agama.agamaId);
      agamaModel.remove(agama);
      update();
    } catch (e) {
      showErrorSnackbar('Delete Error', 'Failed to delete agama: $e');
    }
  }

  Future<void> editAgamaData(AgamaModel updatedData) async {
    try {
      await agamaRepo.editAgamaData(updatedData.agamaId, updatedData);
      final index =
          agamaModel.indexWhere((item) => item.agamaId == updatedData.agamaId);
      if (index != -1) {
        agamaModel[index] = updatedData;
        update();
      }
    } catch (e) {
      showErrorSnackbar('Update Error', 'Failed to update agama: $e');
    }
  }

  void showSuccessSnackbar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  void showErrorSnackbar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.red.shade600, colorText: Colors.white);
  }

  Future<bool> checkConnectivityAndShowDialog() async {
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
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      hideDialog();
      showErrorSnackbar(
          'Network Error', 'Please check your internet connection');
      return false;
    }
    return true;
  }

  void hideDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
