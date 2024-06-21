import 'package:flutter/material.dart';
import 'package:pranamas/controllers/agama_controller.dart';
import 'package:pranamas/models/agama_model.dart';
import 'package:pranamas/screens/edit_agama.dart';

class AgamaDataSource extends DataTableSource {
  final BuildContext context;
  final List<AgamaModel> data;
  final AgamaController controller;

  AgamaDataSource(this.data, this.controller, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final user = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(user.agama)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => showEditAgama(context, controller, user),
                // onPressed: () => controller.editAgamaData(user),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => controller.deleteAgamaUser(user),
              ),
            ],
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
