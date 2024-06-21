import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pranamas/controllers/login_controller.dart';

import '../users/forget_pw.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/images/login_bg.jpg',
            fit: BoxFit.fill,
          )),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.13)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.5),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "PT. Langgeng Pranamas Sentosa",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.actor(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Form(
                        key: controller.loginFromKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email Tidak Boleh Kosong';
                                  }

                                  final emailRegExp = RegExp(
                                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

                                  if (!emailRegExp.hasMatch(value)) {
                                    return 'Alamat email tidak valid';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.direct),
                                  labelText: 'E-Mail',
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Obx(
                                () => TextFormField(
                                  controller: controller.password,
                                  obscureText: controller.hidePassword.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Kata Sandi Tidak Boleh Kosong';
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Iconsax.password_check),
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                        onPressed: () =>
                                            controller.hidePassword.value =
                                                !controller.hidePassword.value,
                                        icon: Icon(controller.hidePassword.value
                                            ? Iconsax.eye_slash
                                            : Iconsax.eye)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // Ingat Saya & forgot pw
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Ingat Saya
                                  Row(
                                    children: [
                                      Obx(
                                        () => SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Checkbox(
                                            value: controller.rememberMe.value,
                                            onChanged: (value) => controller
                                                    .rememberMe.value =
                                                !controller.rememberMe.value,
                                          ),
                                        ),
                                      ),
                                      AutoSizeText(
                                        'Ingat Saya',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      )
                                    ],
                                  ),

                                  // Forgot password
                                  TextButton(
                                      onPressed: () =>
                                          Get.to(() => const ForgetPassword()),
                                      child: AutoSizeText(
                                        'Lupa Kata Sandi?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.apply(
                                                color:
                                                    Colors.blueAccent.shade400),
                                      ))
                                ],
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () =>
                                        controller.emailAndPasswordSignIn(),
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.blueAccent)),
                                    child: const AutoSizeText(
                                      'Sign In',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                    onPressed: () => Get.toNamed('/signup'),
                                    child: const AutoSizeText('Buat Akun')),
                              ),
                            ],
                          ),
                        )),
                    // Divider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                            child: Divider(
                          color: Colors.black,
                          thickness: .5,
                          indent: 60,
                          endIndent: 5,
                        )),
                        AutoSizeText(
                          'atau masuk dengan',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.black),
                        ),
                        const Flexible(
                            child: Divider(
                          color: Colors.black,
                          thickness: .5,
                          indent: 5,
                          endIndent: 60,
                        )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100)),
                      child: IconButton(
                        onPressed: () => controller.googleSignIn(),
                        icon: const Image(
                            width: 24,
                            height: 24,
                            image: AssetImage('assets/images/google.png')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
