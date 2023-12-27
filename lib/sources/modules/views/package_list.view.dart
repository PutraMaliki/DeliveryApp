import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../themes/colors/colors.dart';
import '../../../widgets/widgets.dart';
import '../controllers/controllers.dart';

Widget packageList(Future future, bool isClickable, bool isHistory, int role,
    NavController controller) {
  return FutureBuilder(
    future: future,
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
              return GestureDetector(
                onTap: isClickable
                    ? () {
                        controller.ctrlPackage
                            .getDetailPackage(snapData[2][index]['id_package']);
                        Get.toNamed('/package/detail', parameters: {
                          'id_package': '${snapData[2][index]['id_package']}',
                        });
                      }
                    : null,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: ColorsTheme.secondary),
                  ),
                  color: ColorsTheme.onPrimary,
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReText(
                                text: '${snapData[2][index]['no_resi']}',
                                isHeading: true,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: ColorsTheme.primary,
                              ),
                              const SizedBox(height: 5),
                              ReText(
                                text: '${snapData[2][index]['street_name']}',
                                isHeading: true,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: ColorsTheme.primary,
                              ),
                            ],
                          ),
                        ),
                        role == 2 && !isHistory
                            ? ReElevatedButton(
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: const ReText(
                                        text: 'Confirmation',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.center,
                                      ),
                                      content: const ReText(
                                        text:
                                            'Are you sure you want to complete this package?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const ReText(
                                            text: 'Cancel',
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            controller.ctrlPackage
                                                .completePackage(
                                              snapData[2][index]['id_package'],
                                            );
                                            Get.dialog(
                                              const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                          child: const ReText(
                                            text: 'Complete',
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: const ReText(
                                  text: 'COMPLETE',
                                  isHeading: true,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: ColorsTheme.primary,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ReText(
                                text: '${snapData[2][index]['status']}',
                                isHeading: true,
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: ColorsTheme.primary,
                                textAlign: TextAlign.center,
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (snapData[0] == 404) {
          return const Center(
            child: ReText(
              text: 'No Data',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorsTheme.primary,
              textAlign: TextAlign.center,
            ),
          );
        }
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

class DetailTransactionNavigationView extends GetView<NavController> {
  const DetailTransactionNavigationView({super.key});

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
          child: const Icon(Icons.arrow_back_outlined),
        ),
        title: Row(
          children: [
            const Expanded(
              child: ReText(
                text: 'Detail Transaction',
                isHeading: true,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: ColorsTheme.onPrimary,
                textAlign: TextAlign.center,
              ),
            ),
            if (controller.ctrlAuth.role() == 3)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  onPressed: () async {
                    controller.ctrlPackage
                        .setController(Get.parameters['id_package']);
                    Get.dialog(
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                      barrierDismissible: false,
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 5),
        child: Obx(
          () => FutureBuilder(
            future: controller.ctrlPackage.detailPackage(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List snapData = snapshot.data! as List;
                if (snapData[0] != 404) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: ColorsTheme.primary,
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ReText(
                                        text:
                                            'Resi No. ${snapData[2][0]['noresi']}',
                                        isHeading: true,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: ColorsTheme.onPrimary,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: () {
                                          MapsLauncher.launchQuery(
                                              '${snapData[2][0]['street_name']}');
                                        },
                                        icon: const Icon(
                                          IconsaxBold.map,
                                          color: ColorsTheme.button,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReText(
                                                text:
                                                    '${snapData[2][0]['name']}',
                                                isHeading: true,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: ColorsTheme.onPrimary,
                                              ),
                                              ReText(
                                                text:
                                                    '${snapData[2][0]['street_name']}',
                                                isHeading: true,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: ColorsTheme.onPrimary,
                                              ),
                                              ReText(
                                                text:
                                                    '${snapData[2][0]['building_name']}',
                                                isHeading: true,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: ColorsTheme.onPrimary,
                                              ),
                                              ReText(
                                                text:
                                                    'Room : ${snapData[2][0]['room_number']}',
                                                isHeading: true,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: ColorsTheme.onPrimary,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          ReText(
                                            text:
                                                'Received by : ${snapData[2][0]['name']}',
                                            isHeading: true,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: ColorsTheme.onPrimary,
                                          ),
                                          ReText(
                                            text:
                                                'Postman : ${snapData[2][0]['postman_name']}',
                                            isHeading: true,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: ColorsTheme.onPrimary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    ReText(
                                      text:
                                          '${snapData[2][0]['current_status']}',
                                      isHeading: true,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: ColorsTheme.onPrimary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.ctrlPackage.getPackageDetail(
                                    Get.parameters['id_package']);
                              },
                              child: const Card(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ReText(
                                        text: 'Refresh',
                                        isHeading: true,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: ColorsTheme.primary,
                                        textAlign: TextAlign.center,
                                      ),
                                      Icon(
                                        Icons.refresh,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                controller: ScrollController(),
                                physics: const ClampingScrollPhysics(),
                                itemCount:
                                    snapData[2][0]['detail_resident'].length,
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
                                          Expanded(
                                            child: ReText(
                                              text:
                                                  '${snapData[2][0]['detail_resident'][index]['date']}',
                                              isHeading: true,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: ColorsTheme.primary,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          ReText(
                                            text:
                                                '${snapData[2][0]['detail_resident'][index]['status_name']}',
                                            isHeading: true,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: ColorsTheme.primary,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapData[0] == 404) {
                  return const Center(
                    child: ReText(
                      text: 'No Data',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorsTheme.primary,
                      textAlign: TextAlign.center,
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
    );
  }
}

class FormPageNavigationView extends GetView<NavController> {
  const FormPageNavigationView({super.key});

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
        title: ReText(
          text:
              controller.ctrlAuth.role() != 2 ? 'Form Input' : 'Check Resident',
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
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: ScrollController(),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ReText(
                          text: 'Resi Number',
                          fontWeight: FontWeight.w600,
                          margin:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                        ),
                        ReTextField(
                          textController: controller.ctrlPackage.textCtrlNoResi,
                          hintText: 'Please type your Resi Number here!',
                          validator: controller.ctrlPackage.validateTextCtrl,
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
                          text: 'Name',
                          fontWeight: FontWeight.w600,
                          margin:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                        ),
                        ReTextField(
                          textController: controller.ctrlPackage.textCtrlName,
                          hintText: 'Please type your Name here!',
                          validator: controller.ctrlPackage.validateTextCtrl,
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
                          margin:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                        ),
                        ReTextField(
                          textController: controller.ctrlPackage.textCtrlStreet,
                          hintText: 'Please type your Street here!',
                          validator: controller.ctrlPackage.validateTextCtrl,
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
                          text: 'Building Name',
                          fontWeight: FontWeight.w600,
                          margin:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                        ),
                        ReTextField(
                          textController:
                              controller.ctrlPackage.textCtrlBuildingName,
                          hintText: 'Please type your Building Name here!',
                          validator: controller.ctrlPackage.validateTextCtrl,
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
                          text: 'Room Number',
                          fontWeight: FontWeight.w600,
                          margin:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                        ),
                        ReTextField(
                          textController:
                              controller.ctrlPackage.textCtrlRoomNum,
                          hintText: 'Please type your Room Number here!',
                          validator: controller.ctrlPackage.validateTextCtrl,
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ReElevatedButton(
                          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                          onPressed: () {
                            bool isEdit = bool.parse(Get.parameters['isEdit']!);
                            controller.ctrlPackage.inputForm(
                              context,
                              isEdit,
                              Get.parameters['packageId'],
                            );
                            Get.dialog(
                              const Center(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          },
                          child: ReText(
                            text: controller.ctrlAuth.role() != 2
                                ? 'Submit'
                                : 'Check',
                            color: ColorsTheme.onPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        ReElevatedButton(
                          padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                          onPressed: () {
                            controller.ctrlPackage.clearTextCtrl();
                            Get.back();
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget checkResident(response, packageId, PackageController controller) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      controller: ScrollController(),
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            response != 404 ? const Icon(Icons.check) : const Icon(Icons.close),
            const SizedBox(
              height: 20,
            ),
            ReText(
              text: response != 404 ? 'Resident Found!' : 'Resident Not Found!',
              isHeading: true,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: ColorsTheme.primary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 0,
              color: ColorsTheme.primary,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Close",
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          letterSpacing: 0.125,
                          color: ColorsTheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
                if (response == 404)
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 56,
                          child: VerticalDivider(
                            width: 0.1,
                            color: ColorsTheme.primary,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextButton(
                              onPressed: () {
                                controller.returnPackage(packageId);
                                Get.dialog(
                                  const Center(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                "Return",
                                style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    letterSpacing: 0.125,
                                    color: ColorsTheme.primary,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
