import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/forget_pw_controller.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 24),
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 24, right: 24, left: 24, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              "Lupa kata sandi",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16.0),
            AutoSizeText(
                "Jangan khawatir, terkadang orang juga bisa lupa. masukkan email Anda dan kami akan mengirimkan tautan pengaturan ulang kata sandi",
                style: GoogleFonts.aBeeZee(
                    color: Colors.grey, fontWeight: FontWeight.w400)),
            const SizedBox(height: 16.0),
            Form(
              key: controller.forgetPasswordKey,
              child: TextFormField(
                controller: controller.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email Tidak Boleh Kosong';
                  }

                  final emailRegExp =
                      RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

                  if (!emailRegExp.hasMatch(value)) {
                    return 'Alamat email tidak valid';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.direct),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey)),
                    labelText: 'E-Mail',
                    labelStyle: GoogleFonts.aBeeZee(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.blueAccent)),
                onPressed: () => controller.sendPasswordResetEmail(),
                child: AutoSizeText(
                  'Kirim',
                  style: GoogleFonts.archivoBlack(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
