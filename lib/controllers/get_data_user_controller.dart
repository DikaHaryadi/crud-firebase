import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pranamas/models/data_user_model.dart';
import 'package:pranamas/repository/get_data_user_repo.dart';

class GetDataUserController extends GetxController {
  RxList<DataUserModel> dataUserModel = <DataUserModel>[].obs;
  final isLoadingDataUser = RxBool(false);
  final dataUserRepo = Get.put(GetDataUserRepository());
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchDataUser();
    super.onInit();
  }

  Future<void> fetchDataUser() async {
    try {
      isLoadingDataUser.value = true;
      final dataUsers = await dataUserRepo.fetchDataUser();
      dataUserModel.assignAll(dataUsers);
    } catch (e) {
      dataUserModel.assignAll([]);
      print('Error pada fetchDataUser di get_data_user_controller: $e');
    }
  }

  Future<void> deleteDataUser(DataUserModel user) async {
    try {
      await dataUserRepo.deleteDataUser(user.userId);
      dataUserModel.remove(user);
      print('ini yang dihapus : ${user.userId}');
    } catch (e) {
      print('Failed to delete user: $e');
      // Handle error as needed
    }
  }

  Future<void> editDataUser(DataUserModel user) async {
    try {
      QuerySnapshot querySnapshot = await _db
          .collection('dataUserModel')
          .where('userId', isEqualTo: user.userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update(user.toMap());
      } else {
        throw Exception('No user found with userId: ${user.userId}');
      }
    } catch (e) {
      throw Exception('Failed to edit user: $e');
    }
  }
}
