import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pranamas/screens/homepage.dart';
import 'package:pranamas/screens/master_agama.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RxInt currentPage = 0.obs;

    final List<Widget> pages = [
      const HomePage(),
      const MasterAgama(),
    ];

    void onItemTapped(int index) {
      if (currentPage.value != index) {
        currentPage.value = index;
      }
    }

    return Scaffold(
      body: Obx(() => pages[currentPage.value]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage.value,
        onTap: onItemTapped,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color(0xFF526480),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => onItemTapped(0),
              child: const Icon(Iconsax.menu),
            ),
            activeIcon: const Icon(Iconsax.menu),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => onItemTapped(1),
              child: const Icon(Iconsax.activity),
            ),
            activeIcon: const Icon(Iconsax.activity),
            label: 'Agama',
          ),
        ],
      ),
    );
  }
}
