import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import 'package:skripsi_kos_app/widgets/widgets.dart';
import '../../../../themes/colors/colors.dart';
import '../../controllers/controllers.dart';
import '../../views/views.dart';

class AdminNavigationView extends GetView<NavController> {
  AdminNavigationView({super.key});

  final controllerFP = Get.find<FilePickerController>();
  final controllerTS = Get.find<TextScannerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(
        () => adminPage(controller.selectedIndex()),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomFAB(
        icon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              elevation: 5,
              child: const Icon(
                Icons.file_copy,
                color: ColorsTheme.onPrimary,
              ),
              backgroundColor: ColorsTheme.secondary,
              onTap: () {
                controllerFP.pickFile();
              },
              labelBackgroundColor: ColorsTheme.secondary),
          // SpeedDialChild(
          //     elevation: 5,
          //     child: const Icon(
          //       Icons.list_alt,
          //       color: ColorsTheme.onPrimary,
          //     ),
          //     backgroundColor: ColorsTheme.secondary,
          //     onTap: () {},
          //     labelBackgroundColor: ColorsTheme.secondary),
          SpeedDialChild(
              elevation: 5,
              child: const Icon(
                Icons.add,
                color: ColorsTheme.onPrimary,
              ),
              backgroundColor: ColorsTheme.secondary,
              onTap: () {
                Get.toNamed('/package/form', parameters: {'isEdit': 'false'});
              },
              labelBackgroundColor: ColorsTheme.secondary),
          SpeedDialChild(
              elevation: 5,
              child: const Icon(
                Icons.camera_alt,
                color: ColorsTheme.onPrimary,
              ),
              backgroundColor: ColorsTheme.secondary,
              onTap: () => controllerTS.openCamera(context),
              labelBackgroundColor: ColorsTheme.secondary),
        ],
      ),
    );
  }
}

Widget adminPage(index) {
  if (index == 0) {
    return const AdminHomeView();
  } else if (index == 1) {
    return const SettingNavigationView();
  } else {
    return const Center(
      child: Text('Page not found'),
    );
  }
}
