import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pranamas/controllers/agama_controller.dart';
import 'package:pranamas/models/agama_model.dart';

void showEditAgama(
    BuildContext context, AgamaController controller, AgamaModel model) {
  final agamaController = model.agama.obs;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Agama'),
            Wrap(
              children: [
                ListTile(
                  leading: Obx(() => Radio<String>(
                        value: 'Islam',
                        groupValue: agamaController.value,
                        activeColor: Colors.red,
                        onChanged: (value) => agamaController.value = value!,
                      )),
                  title: Text('Islam'),
                ),
                ListTile(
                  leading: Obx(() => Radio<String>(
                        value: 'Katolik',
                        groupValue: agamaController.value,
                        activeColor: Colors.red,
                        onChanged: (value) => agamaController.value = value!,
                      )),
                  title: Text('Katolik'),
                ),
                ListTile(
                  leading: Obx(() => Radio<String>(
                        value: 'Protestan',
                        groupValue: agamaController.value,
                        activeColor: Colors.red,
                        onChanged: (value) => agamaController.value = value!,
                      )),
                  title: Text('Protestan'),
                ),
                ListTile(
                  leading: Obx(() => Radio<String>(
                        value: 'Konguchu',
                        groupValue: agamaController.value,
                        activeColor: Colors.red,
                        onChanged: (value) => agamaController.value = value!,
                      )),
                  title: Text('Konguchu'),
                ),
                ListTile(
                  leading: Obx(() => Radio<String>(
                        value: 'Budha',
                        groupValue: agamaController.value,
                        activeColor: Colors.red,
                        onChanged: (value) => agamaController.value = value!,
                      )),
                  title: Text('Budha'),
                ),
                ListTile(
                  leading: Obx(() => Radio<String>(
                        value: 'Hindu',
                        groupValue: agamaController.value,
                        activeColor: Colors.red,
                        onChanged: (value) => agamaController.value = value!,
                      )),
                  title: Text('Hindu'),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              model.agama = agamaController.value;
              controller.editAgamaData(model);
              print('Selection valid: ${agamaController.value}');
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}
