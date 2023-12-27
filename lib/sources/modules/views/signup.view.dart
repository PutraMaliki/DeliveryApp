import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skripsi_kos_app/themes/colors/colors.dart';
import 'package:skripsi_kos_app/widgets/widgets.dart';
import '../controllers/controllers.dart';

class SignUpView extends GetView<AuthController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.deepPurple.shade200,
          Colors.deepPurple.shade400,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: SingleChildScrollView(
            controller: ScrollController(),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 56,
                horizontal: 48,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ReText(
                    text: controller.role() == 1
                        ? 'User'
                        : controller.role() == 3
                            ? 'Postman'
                            : 'Admin',
                    isHeading: true,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 56, top: 12),
                    child: Icon(
                      controller.role() == 1
                          ? IconsaxBold.user_square
                          : controller.role() == 3
                              ? IconsaxBold.box
                              : IconsaxBold.key,
                      color: ColorsTheme.primary,
                      size: 160,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ReText(
                        text: 'Name',
                        fontWeight: FontWeight.w600,
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                      ),
                      ReTextField(
                        textController: controller.textCtrlName(),
                        hintText: 'Please type your name here!',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ReText(
                        text: 'Email',
                        fontWeight: FontWeight.w600,
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                      ),
                      ReTextField(
                        textController: controller.textCtrlEmail(),
                        hintText: 'Please type your email here!',
                        validator: controller.validateEmail,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const ReText(
                        text: 'Password',
                        fontWeight: FontWeight.w600,
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                      ),
                      Obx(
                        () => ReTextField(
                          textController: controller.textCtrlPassword(),
                          hintText: 'Please type your password here!',
                          validator: controller.validatePassword,
                          obscureText: controller.isVisible(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.passwordVisibility();
                            },
                            icon: Icon(
                              controller.isVisible()
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ReElevatedButton(
                    onPressed: () {
                      if (controller.role() != 2) {
                        controller.signUp();
                        Get.dialog(
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                          barrierDismissible: false,
                        );
                      } else {
                        Get.toNamed('/signup/regis-building');
                      }
                    },
                    child: ReText(
                      text: controller.role() != 2 ? 'Sign Up' : 'Next',
                      color: ColorsTheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (controller.role() != 1)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Divider(),
                        const SizedBox(
                          height: 16,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            const ReText(text: 'Already have an account? '),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const ReText(
                                text: 'Sign In',
                                color: ColorsTheme.onPrimary,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterBuildingView extends GetView<AuthController> {
  const RegisterBuildingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 56,
              horizontal: 48,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ReText(
                  text: 'Building Information',
                  isHeading: true,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 56, top: 12),
                  child: Icon(
                    IconsaxBold.building_3,
                    color: ColorsTheme.primary,
                    size: 160,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ReText(
                      text: 'Building Name',
                      fontWeight: FontWeight.w600,
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    ),
                    ReTextField(
                      textController: controller.textCtrlBuilding(),
                      hintText: 'Please type building name!',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ReText(
                      text: 'Street',
                      fontWeight: FontWeight.w600,
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    ),
                    ReTextField(
                      textController: controller.textCtrlStreet(),
                      hintText: 'Please type street here!',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const ReText(
                      text: 'Biography',
                      fontWeight: FontWeight.w600,
                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    ),
                    ReTextField(
                      textController: controller.textCtrlBiography(),
                      hintText: 'Please type biography here!',
                      maxLine: 8,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                ReElevatedButton(
                  onPressed: () {
                    controller.signUp();
                    Get.dialog(
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                      barrierDismissible: false,
                    );
                  },
                  child: const ReText(
                    text: 'Sign Up',
                    color: ColorsTheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
