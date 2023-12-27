import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../themes/colors/colors.dart';
import '../../../../widgets/widgets.dart';
import '../../controllers/controllers.dart';
import '../views.dart';

class AdminHomeView extends GetView<NavController> {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ReText(
            text: 'WELCOME, Admin',
            isHeading: true,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ColorsTheme.primary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 2,
            color: ColorsTheme.primary,
          ),
          const SizedBox(height: 10),
          Card(
            color: ColorsTheme.primary,
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ReText(
                      text: 'BIO',
                      isHeading: true,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorsTheme.onPrimary,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    FutureBuilder(
                      future: controller.ctrlAuth.profile(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List snapData = snapshot.data! as List;
                          if (snapData[0] != 404) {
                            return Text(
                              snapData[2]['biography'],
                              style: GoogleFonts.sourceSans3(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: ColorsTheme.onPrimary),
                            );
                          } else if (snapData[0] == 404) {
                            return const Center(
                              child: ReText(text: 'No data found!'),
                            );
                          }
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          ReElevatedButton(
            onPressed: () {
              Get.toNamed('/admin/resident');
            },
            child: const ReText(
              text: 'Show Resident',
              color: ColorsTheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ReText(
                text: 'On Going',
                isHeading: true,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsTheme.primary,
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  controller.ctrlPackage.getPackage();
                },
                icon: const Icon(
                  Icons.refresh,
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => packageList(
                controller.ctrlPackage.listPackage(),
                true,
                false,
                2,
                controller,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ReText(
                text: 'History',
                isHeading: true,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsTheme.primary,
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  controller.ctrlPackage.getPackageHistory();
                },
                icon: const Icon(
                  Icons.refresh,
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => packageList(
                controller.ctrlPackage.listPackageHistory(),
                true,
                true,
                2,
                controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminResidentNavigationView extends GetView<ResidentController> {
  const AdminResidentNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsTheme.primary,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_outlined)),
        title: const ReText(
          text: 'RESIDENT',
          isHeading: true,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: ColorsTheme.onPrimary,
          textAlign: TextAlign.center,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.touch
                  },
                ),
                child: Obx(
                  () => FutureBuilder(
                    future: controller.listResident(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List snapData = snapshot.data! as List;

                        if (snapData[0] != 404) {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            controller: ScrollController(),
                            physics: const ClampingScrollPhysics(),
                            itemCount: snapData[2].length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: ColorsTheme.secondary),
                                ),
                                color: ColorsTheme.onPrimary,
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 35,
                                            backgroundColor:
                                                ColorsTheme.primary,
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReText(
                                                text:
                                                    '${snapData[2][index]['name']}',
                                                isHeading: true,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: ColorsTheme.primary,
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 5),
                                              ReText(
                                                text:
                                                    'Room ${snapData[2][index]['room_no']}',
                                                isHeading: true,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: ColorsTheme.primary,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Get.dialog(
                                            AlertDialog(
                                              title: const ReText(
                                                text: 'Delete Resident',
                                                isHeading: true,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: ColorsTheme.primary,
                                                textAlign: TextAlign.center,
                                              ),
                                              content: const ReText(
                                                text:
                                                    'Are you sure want to delete this resident?',
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const ReText(
                                                    text: 'Cancel',
                                                    isHeading: true,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorsTheme.primary,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    controller.delResident(
                                                        snapData[2][index]
                                                            ['resident_id']);
                                                    Get.dialog(
                                                      const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      barrierDismissible: false,
                                                    );
                                                  },
                                                  child: const ReText(
                                                    text: 'Delete',
                                                    isHeading: true,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: ColorsTheme.primary,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            barrierDismissible: false,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.cancel_presentation,
                                          color: ColorsTheme.secondary,
                                          size: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapData[0] == 404) {
                          return const Center(
                            child: ReText(
                              text: 'No Data Found',
                            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
