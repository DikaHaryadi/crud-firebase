import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pranamas/controllers/agama_controller.dart';
import 'package:pranamas/models/agama_model.dart';

import '../utils/agama_data_source.dart';

class MasterAgama extends StatelessWidget {
  const MasterAgama({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgamaController());
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  border: Border.all(width: 1, color: Colors.blue)),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    color: Colors.blue,
                    child: Text(
                      'FORM INPUT AGAMA',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const Text('Agama'),
                  Wrap(
                    children: [
                      buildRadioTile(controller, 'Islam'),
                      buildRadioTile(controller, 'Katolik'),
                      buildRadioTile(controller, 'Protestan'),
                      buildRadioTile(controller, 'Konguchu'),
                      buildRadioTile(controller, 'Budha'),
                      buildRadioTile(controller, 'Hindu'),
                    ],
                  ),
                  Obx(() => controller.errorMessage.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.errorMessage.value,
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : SizedBox.shrink()),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.validateAgama()) {
                        controller.sendAgamaContent();
                        print('Selection valid: ${controller.agama.value}');
                      } else {
                        print('No selection made.');
                      }
                    },
                    child: const Text('Submit'),
                  )
                ],
              ),
            ),
            buildAgamaList(context, controller),
          ],
        ),
      ),
    );
  }

  Widget buildAgamaList(BuildContext context, AgamaController controller) {
    return Obx(() {
      if (controller.isLoadingAgama.value && controller.agamaModel.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.agamaModel.isEmpty) {
        return const Center(child: Text('No Data Agama Available'));
      } else {
        return SingleChildScrollView(
          child: PaginatedDataTable(
            rowsPerPage: 5,
            columns: const [
              DataColumn(label: Text('Religion')),
              DataColumn(label: Text('Actions')),
            ],
            source: AgamaDataSource(controller.agamaModel, controller, context),
          ),
        );
      }
    });
  }

  Widget buildRadioTile(AgamaController controller, String religion) {
    return ListTile(
      leading: Obx(() => Radio<String>(
            value: religion,
            groupValue: controller.agama.value,
            activeColor: Colors.red,
            onChanged: (value) => controller.agama.value = value!,
          )),
      title: Text(religion),
    );
  }

  void showEditAgamaDialog(
      BuildContext context, AgamaController controller, AgamaModel agamaModel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Agama'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Wrap(
                  children: [
                    buildRadioTile(controller, 'Islam'),
                    buildRadioTile(controller, 'Katolik'),
                    buildRadioTile(controller, 'Protestan'),
                    buildRadioTile(controller, 'Konguchu'),
                    buildRadioTile(controller, 'Budha'),
                    buildRadioTile(controller, 'Hindu'),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                controller.editAgamaData(agamaModel);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
