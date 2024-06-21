import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pranamas/models/data_user_model.dart';
import 'package:pranamas/repository/get_data_user_repo.dart';

class GetDataUserController extends GetxController {
  RxList<DataUserModel> dataUserModel = <DataUserModel>[].obs;
  final isLoadingDataUser = RxBool(false);
  final hasMoreData = RxBool(true);
  DocumentSnapshot? lastDocument;
  final int limit = 10;
  final dataUserRepo = Get.put(GetDataUserRepository());

  @override
  void onInit() {
    fetchDataUser();
    super.onInit();
  }

  Future<void> fetchDataUser() async {
    if (isLoadingDataUser.value || !hasMoreData.value) return;
    try {
      isLoadingDataUser.value = true;
      final dataUser = await dataUserRepo.fetchDataUser(
          lastDocument: lastDocument as QueryDocumentSnapshot?, limit: limit);
      if (dataUser.isEmpty) {
        hasMoreData.value = false;
      } else {
        lastDocument = dataUser.last.documentSnapshot;
        dataUserModel.assignAll(dataUser);
      }
    } catch (e) {
      isLoadingDataUser.value = false;
      hasMoreData.value = false;
    } finally {
      isLoadingDataUser.value = false;
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
}
