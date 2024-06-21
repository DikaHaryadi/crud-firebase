import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/data_user_model.dart';

// class GetDataUserController extends GetxController {
//   static GetDataUserController get instance => Get.find();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final RxList<DataUserModel> users = <DataUserModel>[].obs;
//   final RxBool isLoadingDataUser = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchData();
//   }

//   // Fetch Data Method
//   Future<void> fetchData() async {
//     try {
//       final QuerySnapshot snapshot =
//           await _firestore.collection('dataUserModel').get();
//       final List<DataUserModel> fetchedUsers =
//           snapshot.docs.map((doc) => DataUserModel.fromSnapshot(doc)).toList();
//       users.assignAll(fetchedUsers);
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch data: $e');
//     }
//   }

//   // Edit Data Method
//   Future<void> saveData(DataUserModel user) async {
//     try {
//       isLoadingDataUser.value = true;
//       if (user.id.isNotEmpty) {
//         // Jika ID sudah ada, update dokumen
//         final docRef = _firestore.collection('dataUserModel').doc(user.id);
//         await docRef.update(user.toJson());
//         int index = users.indexWhere((u) => u.id == user.id);
//         if (index != -1) {
//           users[index] = user;
//           users.refresh();
//         }
//         Get.snackbar(
//           'Success',
//           'Data User Edited Successfully',
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           icon: const Icon(Icons.check, color: Colors.white),
//         );
//       } else {
//         // Jika ID tidak ada, tambahkan dokumen baru
//         final docRef =
//             await _firestore.collection('dataUserModel').add(user.toJson());
//         user.id = docRef.id;
//         users.add(user);
//         users.refresh();
//         Get.snackbar(
//           'Success',
//           'Data User Added Successfully',
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           icon: const Icon(Icons.check, color: Colors.white),
//         );
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to save data: $e');
//       print('Error : $e');
//     } finally {
//       isLoadingDataUser.value = false;
//     }
//   }

//   // Delete Method
//   Future<void> deleteData(String id) async {
//     try {
//       final docRef = _firestore.collection('dataUserModel').doc(id);
//       await docRef.delete();
//       users.removeWhere((u) => u.id == id);
//       users.refresh();
//       Get.snackbar(
//         'Success',
//         'Data User Deleted Successfully',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//         icon: const Icon(Icons.check, color: Colors.white),
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to delete data: $e');
//       print('Error : $e');
//     }
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../models/data_user_model.dart';

class GetDataUserController extends GetxController {
  static GetDataUserController get instance => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<DataUserModel> users = <DataUserModel>[].obs;
  final RxBool isLoadingDataUser = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final QuerySnapshot snapshot =
          await _firestore.collection('dataUserModel').get();
      final List<DataUserModel> fetchedUsers =
          snapshot.docs.map((doc) => DataUserModel.fromSnapshot(doc)).toList();
      users.assignAll(fetchedUsers);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
    }
  }

  Future<void> saveData(DataUserModel user) async {
    try {
      isLoadingDataUser.value = true;
      if (user.id.isNotEmpty) {
        // Jika ID sudah ada, update dokumen
        final docRef = _firestore.collection('dataUserModel').doc(user.id);
        await docRef.update(user.toJson());
        int index = users.indexWhere((u) => u.id == user.id);
        if (index != -1) {
          users[index] = user;
          users.refresh();
        }
        Get.snackbar(
          'Success',
          'Data User Edited Successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(Icons.check, color: Colors.white),
        );
      } else {
        // Jika ID tidak ada, tambahkan dokumen baru
        final docRef =
            await _firestore.collection('dataUserModel').add(user.toJson());
        user.id = docRef.id;
        users.add(user);
        users.refresh();
        Get.snackbar(
          'Success',
          'Data User Added Successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(Icons.check, color: Colors.white),
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save data: $e');
      print('Error : $e');
    } finally {
      isLoadingDataUser.value = false;
    }
  }

  Future<void> deleteData(String id) async {
    try {
      final docRef = _firestore.collection('dataUserModel').doc(id);
      await docRef.delete();
      users.removeWhere((u) => u.id == id);
      users.refresh();
      Get.snackbar(
        'Success',
        'Data User Deleted Successfully',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.check, color: Colors.white),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete data: $e');
      print('Error : $e');
    }
  }
}
