import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      expands: false,
                      controller: controller.userNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username Content is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.profile),
                        labelText: 'Username',
                        border: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                        ),
                        enabledBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                        ),
                        errorBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Obx(
                    () => Expanded(
                      child: TextFormField(
                        expands: false,
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
                          border: const OutlineInputBorder().copyWith(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
                          ),
                          enabledBorder: const OutlineInputBorder().copyWith(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder().copyWith(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.black),
                          ),
                          errorBorder: const OutlineInputBorder().copyWith(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                const BorderSide(width: 1, color: Colors.red),
                          ),
                          focusedErrorBorder:
                              const OutlineInputBorder().copyWith(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      expands: false,
                      controller: controller.namaUser,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama User is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.profile),
                        labelText: 'Nama User',
                        border: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                        ),
                        enabledBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                        ),
                        errorBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      expands: false,
                      controller: controller.umurController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Umur is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.profile),
                        labelText: 'Umur',
                        border: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                        ),
                        enabledBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.black),
                        ),
                        errorBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 1, color: Colors.red),
                        ),
                        focusedErrorBorder: const OutlineInputBorder().copyWith(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide:
                              const BorderSide(width: 2, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Jenis Kelamin'),
                          Row(
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
                              const Text('Pria'),
                              Obx(
                                () => Radio<String>(
                                  value: 'Wanita',
                                  groupValue: controller.jenisKelamin.value,
                                  activeColor: Colors.red,
                                  onChanged: (value) =>
                                      controller.jenisKelamin.value = value!,
                                ),
                              ),
                              const Text('Wanita'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                        width: 16), // Add some spacing between columns
                    Center(
                      child: SizedBox(
                        width: 120,
                        height: 50,
                        child: Obx(
                          () => DropdownButton<String>(
                            value: controller.agama.value,
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
                              controller.agama.value = newValue!;
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
                      ),
                    ),
                    const SizedBox(
                        width: 16), // Add some spacing between columns
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: Obx(
                          () => DropdownButton<String>(
                            value: controller.pendidikan.value,
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
                              controller.pendidikan.value = newValue!;
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: controller.alamat,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.map),
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
              const SizedBox(height: 15.0),
              ElevatedButton(
                  onPressed: controller.sendDataUserContent,
                  child: const Text('Buat User'))
            ],
          )),
    );
  }
}
