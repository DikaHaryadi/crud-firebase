import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pranamas/controllers/data_user_controller.dart';

import '../utils/firebase_storage_service.dart';

class CreateDataUser extends StatelessWidget {
  const CreateDataUser({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DataUserController());
    final storage = Get.put(FirebaseStorageService());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: const EdgeInsets.only(left: 24),
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Tambah User'),
      ),
      body: Form(
          key: controller.dataUserFormKey,
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            children: [
              Obx(
                () => storage.image.value != null
                    ? Center(
                        child: InkWell(
                        onTap: () => storage.image(),
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
                      ))
                    : TextButton(
                        onPressed: () => storage.pickImage(),
                        child: const Text(
                          'Masukan Foto User',
                        )),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: controller.userNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username Content is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.profile),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 8.0),
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  obscureText: controller.hidePassword.value,
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
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye)),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: controller.namaUser,
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
                controller: controller.userId,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'userId is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.profile),
                  labelText: 'userId',
                ),
              ),
              const SizedBox(height: 12.0),
              const Text('Agama'),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  children: [
                    Obx(
                      () => Radio<String>(
                        value: 'Islam',
                        groupValue: controller.agama.value,
                        activeColor: Colors.red,
                        onChanged: (value) => controller.agama.value = value!,
                      ),
                    ),
                    const Text(
                      'Islam',
                    ),
                    Expanded(child: Container()),
                    Obx(
                      () => Radio<String>(
                        value: 'Katolik',
                        groupValue: controller.agama.value,
                        activeColor: Colors.red,
                        onChanged: (value) => controller.agama.value = value!,
                      ),
                    ),
                    const Text(
                      'Katolik',
                    ),
                    Expanded(child: Container()),
                    Obx(
                      () => Radio<String>(
                        value: 'Protestan',
                        groupValue: controller.agama.value,
                        activeColor: Colors.red,
                        onChanged: (value) => controller.agama.value = value!,
                      ),
                    ),
                    const Text(
                      'Protestan',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  children: [
                    Obx(
                      () => Radio<String>(
                        value: 'Konguchu',
                        groupValue: controller.agama.value,
                        activeColor: Colors.red,
                        onChanged: (value) => controller.agama.value = value!,
                      ),
                    ),
                    const Text(
                      'Konguchu',
                    ),
                    Expanded(child: Container()),
                    Obx(
                      () => Radio<String>(
                        value: 'Budha',
                        groupValue: controller.agama.value,
                        activeColor: Colors.red,
                        onChanged: (value) => controller.agama.value = value!,
                      ),
                    ),
                    const Text(
                      'Budha',
                    ),
                    Expanded(child: Container()),
                    Obx(
                      () => Radio<String>(
                        value: 'Hindu',
                        groupValue: controller.agama.value,
                        activeColor: Colors.red,
                        onChanged: (value) => controller.agama.value = value!,
                      ),
                    ),
                    const Text(
                      'Hindu',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              const Text('Jenis Kelamin'),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Row(
                  children: [
                    Obx(
                      () => Radio<String>(
                        value: 'Pria',
                        groupValue: controller.jenisKelamin.value,
                        activeColor: Colors.red,
                        onChanged: (value) =>
                            controller.jenisKelamin.value = value!,
                      ),
                    ),
                    const Text(
                      'Pria',
                    ),
                    Expanded(child: Container()),
                    Obx(
                      () => Radio<String>(
                        value: 'Wanita',
                        groupValue: controller.jenisKelamin.value,
                        activeColor: Colors.red,
                        onChanged: (value) =>
                            controller.jenisKelamin.value = value!,
                      ),
                    ),
                    const Text(
                      'Wanita',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: controller.pendidikan,
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
                controller: controller.alamat,
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
              const SizedBox(height: 15.0),
              ElevatedButton(
                  onPressed: controller.sendDataUserContent,
                  child: const Text('Buat User'))
            ],
          )),
    );
  }
}
