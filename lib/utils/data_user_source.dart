import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pranamas/models/data_user_model.dart';
import '../controllers/get_data_user_controller.dart';

class DataUserDataSource extends DataTableSource {
  final List<DataUserModel> data;
  final GetDataUserController controller;

  DataUserDataSource(this.data, this.controller);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final user = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Image.network(user.photoUser, width: 50, height: 50)),
        DataCell(Text(user.userName)),
        DataCell(Text(user.password)),
        DataCell(Text(user.namaUser)),
        DataCell(Text(user.userId)),
        DataCell(Text(user.agama)),
        DataCell(Text(user.jenisKelamin)),
        DataCell(Text(user.pendidikan)),
        DataCell(Text(user.alamat)),
        DataCell(
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Delete user
              controller.deleteDataUser(user);
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}