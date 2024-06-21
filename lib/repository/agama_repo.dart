import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pranamas/models/agama_model.dart';

class AgamaRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> saveAgamaContent(AgamaModel agamaModel) async {
    try {
      DocumentReference docRef =
          await _db.collection('agamaMaster').add(agamaModel.toJson());
      return docRef.id; // This will be the auto-generated ID by Firestore
    } catch (e) {
      Get.snackbar(
        'Error Saving Data',
        'Unable to save the data: ${e.toString()}',
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        icon: const Icon(Iconsax.warning_2, color: Colors.white),
      );
      rethrow;
    }
  }

  Future<List<AgamaModel>> fetchDataAgama() async {
    try {
      final documentSnapshot = await _db.collection('agamaMaster').get();
      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs
            .map((e) => AgamaModel.fromSnapshot(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('ada yang salah di fetchDataUser pada repository nya: $e');
      throw Get.snackbar(
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

  Future<void> deleteAgama(String documentId) async {
    try {
      await _db.collection('agamaMaster').doc(documentId).delete();

      Get.snackbar(
        'Success',
        'Agama data deleted successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Iconsax.trash, color: Colors.white),
      );
    } catch (e) {
      Get.snackbar(
        'Delete Error',
        'Failed to delete agama data: ${e.toString()}',
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        icon: const Icon(Iconsax.warning_2, color: Colors.white),
      );
    }
  }

  Future<void> editAgamaData(String documentId, AgamaModel updatedData) async {
    try {
      await _db
          .collection('agamaMaster')
          .doc(documentId)
          .update(updatedData.toJson());

      Get.snackbar(
        'Success',
        'Agama data updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Iconsax.edit, color: Colors.white),
      );
    } catch (e) {
      Get.snackbar(
        'Update Error',
        'Failed to update agama data: ${e.toString()}',
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        icon: const Icon(Iconsax.warning_2, color: Colors.white),
      );
    }
  }
}
