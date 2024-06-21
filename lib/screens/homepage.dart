import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pranamas/controllers/auth_controller.dart';
import 'package:pranamas/screens/create_data_user.dart';

import '../controllers/get_data_user_controller.dart';
import '../utils/data_user_source.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetDataUserController());
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Data User'),
                IconButton(
                    onPressed: () => AuthenticationRepository.instance.logOut(),
                    icon: const Icon(Iconsax.logout))
              ],
            ),
            ElevatedButton(
              onPressed: () => Get.to(() => const CreateDataUser()),
              child: const Text('Tambahkan Data'),
            ),
            Obx(() {
              if (controller.isLoadingDataUser.value &&
                  controller.users.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.users.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                return PaginatedDataTable(
                  header: const Text('Data Users'),
                  columns: const [
                    DataColumn(label: Text('Photo')),
                    DataColumn(label: Text('User Name')),
                    DataColumn(label: Text('Password')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Age')),
                    DataColumn(label: Text('Religion')),
                    DataColumn(label: Text('Gender')),
                    DataColumn(label: Text('Education')),
                    DataColumn(label: Text('Address')),
                    DataColumn(label: Text('Actions')),
                  ],
                  source: DataUserDataSource(controller),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
