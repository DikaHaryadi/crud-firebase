import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pranamas/utils/firebase_storage_service.dart';

import '../controllers/get_data_user_controller.dart';
import '../models/data_user_model.dart';

class EditUserDialog extends StatefulWidget {
  final DataUserModel user;
  final GetDataUserController controller;

  EditUserDialog({required this.user, required this.controller});

  @override
  _EditUserDialogState createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController namaUserController;
  late TextEditingController umurController;
  late TextEditingController agamaController;
  late TextEditingController jenisKelaminController;
  late TextEditingController pendidikanController;
  late TextEditingController alamatController;

  final storage = Get.put(FirebaseStorageService());

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.user.userName);
    passwordController = TextEditingController(text: widget.user.password);
    namaUserController = TextEditingController(text: widget.user.namaUser);
    umurController = TextEditingController(text: widget.user.umur);
    agamaController = TextEditingController(text: widget.user.agama);
    jenisKelaminController =
        TextEditingController(text: widget.user.jenisKelamin);
    pendidikanController = TextEditingController(text: widget.user.pendidikan);
    alamatController = TextEditingController(text: widget.user.alamat);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit User'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => storage.image.value != null
                  ? Center(
                      child: InkWell(
                        onTap: () => storage.pickImage(),
                        child: Stack(
                          children: [
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(storage.image.value!),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                  width: 4,
                                  color: Colors.black,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                                shape: BoxShape.circle,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 4,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.green,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : widget.user.photoUser.isNotEmpty
                      ? Center(
                          child: InkWell(
                            onTap: () => storage.pickImage(),
                            child: Stack(
                              children: [
                                Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(widget.user.photoUser),
                                        fit: BoxFit.cover),
                                    border: Border.all(
                                      width: 4,
                                      color: Colors.black,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 4,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      color: Colors.green,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : TextButton(
                          onPressed: () => storage.pickImage(),
                          child: const Text('Masukan Foto User'),
                        ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: userNameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: namaUserController,
              decoration: InputDecoration(labelText: 'Nama User'),
            ),
            TextField(
              controller: umurController,
              decoration: InputDecoration(labelText: 'Umur'),
            ),
            TextField(
              controller: agamaController,
              decoration: InputDecoration(labelText: 'Agama'),
            ),
            TextField(
              controller: jenisKelaminController,
              decoration: InputDecoration(labelText: 'Jenis Kelamin'),
            ),
            TextField(
              controller: pendidikanController,
              decoration: InputDecoration(labelText: 'Pendidikan'),
            ),
            TextField(
              controller: alamatController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Get.back();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () async {
            String? photoUrl;
            if (storage.image.value != null) {
              // Upload the image to Firebase Storage and get the URL
              photoUrl = await storage.uploadImage(storage.image.value!);
            } else {
              photoUrl = widget.user.photoUser;
            }
            final updatedUser = DataUserModel(
              id: widget.user.id,
              photoUser: photoUrl,
              userName: userNameController.text,
              password: passwordController.text,
              namaUser: namaUserController.text,
              umur: umurController.text,
              agama: agamaController.text,
              jenisKelamin: jenisKelaminController.text,
              pendidikan: pendidikanController.text,
              alamat: alamatController.text,
            );
            widget.controller.saveData(updatedUser);
            Get.back();
          },
        ),
      ],
    );
  }
}
