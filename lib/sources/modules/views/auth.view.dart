import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:skripsi_kos_app/bindings.dart';

import 'package:skripsi_kos_app/themes/colors/colors.dart';
import 'package:skripsi_kos_app/widgets/widgets.dart';
import '../controllers/controllers.dart';
import '../views/views.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.role() != 0 && controller.session()) {
        AuthBinding().dependencies();
        PackageBinding().dependencies();
        if (controller.role() == 1) {
          return const UserNavigationView();
        } else if (controller.role() == 2) {
          FilePickerBinding().dependencies();
          TextScannerBinding().dependencies();
          // ResidentBinding().dependencies();
          return AdminNavigationView();
        } else {
          TextScannerBinding().dependencies();
          UrlLaunchierBinding().dependencies();
          return PostmanNavigationView();
        }
      } else {
        return const SelectRoleView();
      }
    });
  }
}

class SelectRoleView extends GetView<AuthController> {
  const SelectRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: deviceSize.width / 2.5,
            child: const AspectRatio(
              aspectRatio: 1 / 1,
              child: Image(
                image: AssetImage('lib/assets/images/app_launcher_icon.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
            child: Center(
              child: Card(
                color: ColorsTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 56, horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ReText(
                        text: 'Select Role',
                        isHeading: true,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: ColorsTheme.onPrimary,
                        textAlign: TextAlign.center,
                      ),
                      const Icon(
                        IconsaxBold.arrow_down,
                        size: 56,
                        color: ColorsTheme.onPrimary,
                      ),
                      ReElevatedButton(
                        onPressed: () {
                          controller.role(1);
                          Get.toNamed('/signin');
                          debugPrint(
                              'Role: ${controller.role()}\nSession: ${controller.session()}');
                        },
                        child: const ReText(
                          text: 'Continue as User',
                          color: ColorsTheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ReElevatedButton(
                        onPressed: () {
                          controller.role(3);
                          Get.toNamed('/signin');
                          debugPrint(
                              'Role: ${controller.role()}\nSession: ${controller.session()}');
                        },
                        child: const ReText(
                          text: 'Continue as Postman',
                          color: ColorsTheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ReElevatedButton(
                        onPressed: () {
                          controller.role(2);
                          Get.toNamed('/signin');
                          debugPrint(
                              'Role: ${controller.role()}\nSession: ${controller.session()}');
                        },
                        child: const ReText(
                          text: 'Continue as Admin',
                          color: ColorsTheme.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
