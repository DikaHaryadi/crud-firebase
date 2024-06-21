import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assets/images/splash_bg.jpeg',
            fit: BoxFit.fill,
          )),
          Positioned(
              child: Container(
            width: Get.width,
            height: Get.height,
            padding: const EdgeInsets.only(bottom: 24.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(1),
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  child: Text(
                    "PT. Langgeng Pranamas Sentosa",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.actor(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.0025,
                ),
                ElevatedButton(
                    onPressed: () => Get.toNamed('/login'),
                    child: const Text('Selanjutnya'))
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
