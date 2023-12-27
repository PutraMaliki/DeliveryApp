import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_kos_app/sources/modules/views/views.dart';

import 'package:skripsi_kos_app/widgets/widgets.dart';
import '../../controllers/controllers.dart';

class UserNavigationView extends GetView<NavController> {
  const UserNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(
        () => userPage(controller.selectedIndex()),
      ),
      bottomNavigationBar: Obx(
        () => ReNavbar(
          index: controller.selectedIndex(),
          onTap: (value) {
            controller.selectedIndex(value);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                IconsaxBold.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconsaxBold.setting_2,
              ),
              label: 'Setting',
            ),
          ],
        ),
      ),
    );
  }
}

Widget userPage(index) {
  if (index == 0) {
    return const UserHomeView();
  } else if (index == 1) {
    return const SettingNavigationView();
  } else {
    return const Center(
      child: Text('Page not found'),
    );
  }
}
