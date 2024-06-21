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
  late String agama;
  late String jenisKelamin;
  late String pendidikan;
  late TextEditingController alamatController;

  final storage = Get.put(FirebaseStorageService());

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.user.userName);
    passwordController = TextEditingController(text: widget.user.password);
    namaUserController = TextEditingController(text: widget.user.namaUser);
    umurController = TextEditingController(text: widget.user.umur);
    agama = widget.user.agama;
    jenisKelamin = widget.user.jenisKelamin;
    pendidikan = widget.user.pendidikan;
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
              decoration: InputDecoration(
                labelText: 'Username',
                border: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                enabledBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.black),
                ),
                errorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
                focusedErrorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                enabledBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.black),
                ),
                errorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
                focusedErrorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: namaUserController,
              decoration: InputDecoration(
                labelText: 'Nama User',
                border: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                enabledBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.black),
                ),
                errorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
                focusedErrorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: umurController,
              decoration: InputDecoration(
                labelText: 'Umur',
                border: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                enabledBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.black),
                ),
                errorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
                focusedErrorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                ),
              ),
            ),
            SizedBox(
              width: 120,
              height: 50,
              child: DropdownButton<String>(
                value: agama,
                icon: const Icon(Icons.arrow_downward),
                hint: const Text('Pilih Agama'),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.red,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    agama = newValue!;
                  });
                },
                items: <String>[
                  'Islam',
                  'Katolik',
                  'Protestan',
                  'Konguchu',
                  'Budha',
                  'Hindu'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Jenis Kelamin'),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Pria',
                      groupValue: jenisKelamin,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value!;
                        });
                      },
                    ),
                    const Text('Pria'),
                    Radio<String>(
                      value: 'Wanita',
                      groupValue: jenisKelamin,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value!;
                        });
                      },
                    ),
                    const Text('Wanita'),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: DropdownButton<String>(
                value: pendidikan,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                hint: const Text('Pilih Pendidikan Terakhir'),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.red,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    pendidikan = newValue!;
                  });
                },
                items: <String>[
                  'SD',
                  'SMP',
                  'SMA / SLTA SEDERAJAT',
                  'STRATA 1',
                  'MAGISTER',
                  'PROFESSOR'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: alamatController,
              decoration: InputDecoration(
                labelText: 'Alamat',
                border: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                enabledBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.black),
                ),
                errorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 1, color: Colors.red),
                ),
                focusedErrorBorder: const OutlineInputBorder().copyWith(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(width: 2, color: Colors.red),
                ),
              ),
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
              agama: agama,
              jenisKelamin: jenisKelamin,
              pendidikan: pendidikan,
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
