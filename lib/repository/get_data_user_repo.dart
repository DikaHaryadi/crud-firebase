import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pranamas/models/data_user_model.dart';

class GetDataUserRepository extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<DataUserModel>> fetchDataUser() async {
    try {
      final documentSnapshot = await _db.collection('dataUserModel').get();
      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs
            .map((e) => DataUserModel.fromSnapshot(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('ada yang salah di fetchDataUser pada repository nya : $e');
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

  Future<void> addDataUser(DataUserModel newUser) async {
    try {
      await _db.collection('dataUserModel').add(newUser.toJson());
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  Future<void> deleteDataUser(String docId) async {
    try {
      await _db.collection('dataUserModel').doc(docId).delete();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
