import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/get_data_user_controller.dart';
import '../models/data_user_model.dart';
import '../utils/firebase_storage_service.dart';

void showEditDialog(BuildContext context, GetDataUserController controller,
    DataUserModel user) {
  final hidePassword = true.obs;
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController(text: user.userName);
  final _passwordController = TextEditingController(text: user.password);
  final _namaUserController = TextEditingController(text: user.namaUser);
  final _userIdController = TextEditingController(text: user.userId);
  final _agamaController = user.agama.obs;
  final _jenisKelaminController = user.jenisKelamin.obs;
  final _pendidikanController = TextEditingController(text: user.pendidikan);
  final _alamatController = TextEditingController(text: user.alamat);
  final firebaseStorageService = Get.put(FirebaseStorageService());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit User'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(labelText: 'User Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter user name';
                    }
                    return null;
                  },
                ),
                Obx(
                  () => TextFormField(
                    controller: _passwordController,
                    obscureText: hidePassword.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () =>
                            hidePassword.value = !hidePassword.value,
                        icon: Icon(hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _namaUserController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama User is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.profile),
                    labelText: 'Nama User',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _userIdController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'UserId is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.profile),
                    labelText: 'UserId',
                  ),
                ),
                const SizedBox(height: 12.0),
                Text('Agama'),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    children: [
                      Obx(
                        () => Radio<String>(
                          value: 'Islam',
                          groupValue: _agamaController.value,
                          activeColor: Colors.red,
                          onChanged: (value) => _agamaController.value = value!,
                        ),
                      ),
                      Text('Islam'),
                      Expanded(child: Container()),
                      Obx(
                        () => Radio<String>(
                          value: 'Katolik',
                          groupValue: _agamaController.value,
                          activeColor: Colors.red,
                          onChanged: (value) => _agamaController.value = value!,
                        ),
                      ),
                      Text('Katolik'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Obx(
                      () => Radio<String>(
                        value: 'Protestan',
                        groupValue: _agamaController.value,
                        activeColor: Colors.red,
                        onChanged: (value) => _agamaController.value = value!,
                      ),
                    ),
                    Text('Protestan'),
                    Expanded(child: Container()),
                    Obx(
                      () => Radio<String>(
                        value: 'Hindu',
                        groupValue: _agamaController.value,
                        activeColor: Colors.red,
                        onChanged: (value) => _agamaController.value = value!,
                      ),
                    ),
                    Text('Hindu'),
                  ],
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    children: [
                      Obx(
                        () => Radio<String>(
                          value: 'Konghucu',
                          groupValue: _agamaController.value,
                          activeColor: Colors.red,
                          onChanged: (value) => _agamaController.value = value!,
                        ),
                      ),
                      Text('Konghucu'),
                      Expanded(child: Container()),
                      Obx(
                        () => Radio<String>(
                          value: 'Budha',
                          groupValue: _agamaController.value,
                          activeColor: Colors.red,
                          onChanged: (value) => _agamaController.value = value!,
                        ),
                      ),
                      Text('Budha'),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Text('Jenis Kelamin'),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Row(
                    children: [
                      Obx(
                        () => Radio<String>(
                          value: 'Pria',
                          groupValue: _jenisKelaminController.value,
                          activeColor: Colors.red,
                          onChanged: (value) =>
                              _jenisKelaminController.value = value!,
                        ),
                      ),
                      Text('Pria'),
                      Expanded(child: Container()),
                      Obx(
                        () => Radio<String>(
                          value: 'Wanita',
                          groupValue: _jenisKelaminController.value,
                          activeColor: Colors.red,
                          onChanged: (value) =>
                              _jenisKelaminController.value = value!,
                        ),
                      ),
                      Text('Wanita'),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _pendidikanController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pendidikan is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.profile),
                    labelText: 'Pendidikan',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: _alamatController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.profile),
                    labelText: 'Alamat',
                  ),
                ),
                const SizedBox(height: 8.0),
                Obx(() {
                  return Column(
                    children: [
                      if (firebaseStorageService.image.value != null)
                        Image.file(
                          firebaseStorageService.image.value!,
                          height: 100,
                        ),
                      TextButton.icon(
                        icon: Icon(Iconsax.image),
                        label: Text('Change Photo'),
                        onPressed: () => firebaseStorageService.pickImage(),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                user.userName = _userNameController.text;
                user.password = _passwordController.text;
                user.namaUser = _namaUserController.text;
                user.userId = _userIdController.text;
                user.agama = _agamaController.value;
                user.jenisKelamin = _jenisKelaminController.value;
                user.pendidikan = _pendidikanController.text;
                user.alamat = _alamatController.text;
                // Jika ada gambar baru yang dipilih, upload dan perbarui URL photoUser
                if (firebaseStorageService.image.value != null) {
                  // Contoh pengunggahan gambar ke Firebase Storage dan mendapatkan URL
                  // Anda harus mengimplementasikan fungsi ini di FirebaseStorageService
                  firebaseStorageService
                      .uploadImage(firebaseStorageService.image.value!)
                      .then((url) {
                    user.photoUser = url;
                    controller.editDataUser(user);
                    Navigator.of(context).pop();
                  });
                } else {
                  controller.editDataUser(user);
                  Navigator.of(context).pop();
                }
              }
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}
