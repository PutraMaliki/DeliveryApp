import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:skripsi_kos_app/widgets/widgets.dart';
import '../../../themes/colors/colors.dart';
import '../controllers/controllers.dart';

class SettingNavigationView extends GetView<NavController> {
  const SettingNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 5),
        child: Obx(
          () => FutureBuilder(
            future: controller.ctrlAuth.profile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List snapData = snapshot.data! as List;
                controller.ctrlAuth.setControllerProfile(snapData[2]);
                if (snapData[0] != 404) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 80,
                              ),
                              const Center(
                                child: CircleAvatar(
                                  backgroundColor: ColorsTheme.back2,
                                  radius: 50,
                                  child: ReText(
                                    text: '1',
                                    color: ColorsTheme.primary,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ), //Text
                                ),
                              ),
                              const SizedBox(height: 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const ReText(
                                    text: 'NAME',
                                    fontWeight: FontWeight.w600,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 12),
                                  ),
                                  ReTextField(
                                    textController:
                                        controller.ctrlAuth.textCtrlName(),
                                    hintText: 'Please type your new name here!',
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Visibility(
                                visible: controller.ctrlAuth.role() == 1
                                    ? true
                                    : false,
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const ReText(
                                          text: 'SURNAME',
                                          fontWeight: FontWeight.w600,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 12),
                                        ),
                                        ReTextField(
                                          textController: controller.ctrlAuth
                                              .textCtrlSurname(),
                                          hintText:
                                              'Please type your new surname here!',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const ReText(
                                    text: 'EMAIL',
                                    fontWeight: FontWeight.w600,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 12),
                                  ),
                                  ReTextField(
                                    textController:
                                        controller.ctrlAuth.textCtrlEmail(),
                                    hintText:
                                        'Please type your your email here!',
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
                                    text: 'PASSWORD',
                                    fontWeight: FontWeight.w600,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 12),
                                  ),
                                  ReTextField(
                                    textController:
                                        controller.ctrlAuth.textCtrlPassword(),
                                    hintText:
                                        'Please type your new password here!',
                                    obscureText: true,
                                    readOnly: true,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Visibility(
                                visible: controller.ctrlAuth.role() == 2
                                    ? true
                                    : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const ReText(
                                      text: 'EDIT BUILDING',
                                      fontWeight: FontWeight.w600,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 12),
                                    ),
                                    ExpansionTile(
                                      title: const ReText(
                                        text: '',
                                        fontWeight: FontWeight.w600,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 12),
                                      ),
                                      children: <Widget>[
                                        ListTile(
                                          title: SingleChildScrollView(
                                            controller: ScrollController(),
                                            physics:
                                                const BouncingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const ReText(
                                                      text: 'BUILDING NAME',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2,
                                                              horizontal: 12),
                                                    ),
                                                    ReTextField(
                                                      textController: controller
                                                          .ctrlAuth
                                                          .textCtrlBuilding(),
                                                      hintText:
                                                          'Please type your new building name here!',
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const ReText(
                                                      text: 'STREET',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2,
                                                              horizontal: 12),
                                                    ),
                                                    ReTextField(
                                                      textController: controller
                                                          .ctrlAuth
                                                          .textCtrlStreet(),
                                                      hintText:
                                                          'Please type your your street here!',
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const ReText(
                                                      text: 'BIOGRAPHY',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2,
                                                              horizontal: 12),
                                                    ),
                                                    ReTextField(
                                                      textController: controller
                                                          .ctrlAuth
                                                          .textCtrlBiography(),
                                                      hintText:
                                                          'Please type your new bio here!',
                                                      maxLine: 5,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 35),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ReElevatedButton(
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 5, 25, 5),
                                    onPressed: () {
                                      Get.dialog(
                                        const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                      controller.ctrlAuth.updateProfile();
                                    },
                                    child: const ReText(
                                      text: 'Save',
                                      color: ColorsTheme.onPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  ReElevatedButton(
                                    padding:
                                        const EdgeInsets.fromLTRB(25, 5, 25, 5),
                                    onPressed: () {
                                      controller.ctrlAuth.getProfile(
                                        controller.ctrlAuth.uid(),
                                        controller.ctrlAuth.role(),
                                      );
                                    },
                                    backgroundColor: ColorsTheme.primary,
                                    child: const ReText(
                                      text: 'Cancel',
                                      color: ColorsTheme.onPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 35),
                              ReElevatedButton(
                                onPressed: () {
                                  controller.ctrlAuth.signOut();
                                },
                                child: const ReText(
                                  text: 'Sign Out',
                                  color: ColorsTheme.onPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapData[0] == 404) {
                  return const Center(
                    child: ReText(text: 'No data found!'),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
