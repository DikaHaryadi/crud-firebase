import 'package:get/get.dart';

import '../../users/network_manager.dart';
import '../firebase_storage_service.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseStorageService());
    Get.put(NetworkManager());
  }
}
