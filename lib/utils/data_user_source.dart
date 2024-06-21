import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/get_data_user_controller.dart';
import '../screens/edit_data_user.dart';

class DataUserDataSource extends DataTableSource {
  final GetDataUserController controller;
  DataUserDataSource(this.controller);

  @override
  DataRow getRow(int index) {
    final user = controller.users[index];
    return DataRow.byIndex(index: index, cells: [
      DataCell(Image.network(user.photoUser, width: 50, height: 50)),
      DataCell(Text(user.userName)),
      DataCell(Text(user.namaUser)),
      DataCell(Text(user.password)),
      DataCell(Text(user.umur)),
      DataCell(Text(user.agama)),
      DataCell(Text(user.jenisKelamin)),
      DataCell(Text(user.pendidikan)),
      DataCell(Text(user.alamat)),
      DataCell(Row(
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Show edit dialog
              showDialog(
                context: Get.context!,
                builder: (context) {
                  return EditUserDialog(user: user, controller: controller);
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await controller.deleteData(user.id);
            },
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.users.length;

  @override
  int get selectedRowCount => 0;
}
