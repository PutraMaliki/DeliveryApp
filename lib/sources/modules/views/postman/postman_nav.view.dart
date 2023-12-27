import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skripsi_kos_app/widgets/widgets.dart';
import '../../../../themes/colors/colors.dart';
import '../../controllers/controllers.dart';
import '../../views/views.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class PostmanNavigationView extends GetView<NavController> {
  PostmanNavigationView({super.key});

  final controllerTS = Get.find<TextScannerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(
        () => postmanPage(controller.selectedIndex()),
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
                Icons.camera_alt,
                color: ColorsTheme.onPrimary,
              ),
              backgroundColor: ColorsTheme.secondary,
              onTap: () => controllerTS.openCamera(context),
              labelBackgroundColor: ColorsTheme.secondary),
          // FAB 2
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
        ],
      ),
    );
  }
}

Widget postmanPage(index) {
  if (index == 0) {
    return const PostmanHomeView();
  } else if (index == 1) {
    return const SettingNavigationView();
  } else {
    return const Center(
      child: Text('Page not found'),
    );
  }
}

class CustomFAB extends StatefulWidget {
  final double? size;
  final Curve curve;
  final bool visible;
  final Color iconColor;
  final Color backgroundColor;
  final List<SpeedDialChild> children;
  final AnimatedIconData icon;
  const CustomFAB(
      {super.key,
      this.size = 25,
      this.curve = Curves.bounceIn,
      this.visible = true,
      this.iconColor = ColorsTheme.onPrimary,
      this.backgroundColor = ColorsTheme.secondary,
      required this.icon,
      required this.children});

  @override
  State<CustomFAB> createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: widget.icon,
      animatedIconTheme:
          IconThemeData(size: widget.size, color: widget.iconColor),
      backgroundColor: widget.backgroundColor,
      visible: widget.visible,
      curve: widget.curve,
      children: widget.children,
    );
  }
}
