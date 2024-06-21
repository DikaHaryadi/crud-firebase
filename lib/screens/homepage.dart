import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        child: Obx(() {
          if (controller.isLoadingDataUser.value &&
              controller.dataUserModel.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.dataUserModel.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                const Text('Data User'),
                ElevatedButton(
                  onPressed: () => Get.to(() => const CreateDataUser()),
                  child: const Text('Tambahkan Data'),
                ),
                NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                      Future.microtask(() {
                        controller.fetchDataUser();
                      });
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    child: PaginatedDataTable(
                      header: const Text('User Data'),
                      rowsPerPage: 5,
                      columns: const [
                        DataColumn(label: Text('Photo')),
                        DataColumn(label: Text('Username')),
                        DataColumn(label: Text('Password')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('User ID')),
                        DataColumn(label: Text('Religion')),
                        DataColumn(label: Text('Gender')),
                        DataColumn(label: Text('Education')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Hapus')),
                      ],
                      source: DataUserDataSource(
                          controller.dataUserModel, controller, context),
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
