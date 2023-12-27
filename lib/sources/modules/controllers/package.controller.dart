import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/views.dart';
import 'controllers.dart';
import '../../services/services.dart';

class PackageController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    listPackage = packageService
        .readPackage(authController.uid(), authController.role())
        .obs;
    listPackageHistory = packageService
        .readPackageHistory(authController.uid(), authController.role())
        .obs;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    textCtrlNoResi.dispose();
    textCtrlName.dispose();
    textCtrlStreet.dispose();
    textCtrlBuildingName.dispose();
    textCtrlRoomNum.dispose();
  }

  // Variable Declaration

  PackageService packageService = PackageService();
  AuthController authController = Get.find<AuthController>();

  late Rx<Future> listPackage;
  late Rx<Future> listPackageHistory;

  Rx<Future> detailPackage = Future.value().obs;

  TextEditingController textCtrlNoResi = TextEditingController();
  TextEditingController textCtrlName = TextEditingController();
  TextEditingController textCtrlStreet = TextEditingController();
  TextEditingController textCtrlBuildingName = TextEditingController();
  TextEditingController textCtrlRoomNum = TextEditingController();

  getDetailPackage(packageId) {
    detailPackage = packageService.readPackageDetail(packageId).obs;
  }

  getPackageDetail(packageId) {
    detailPackage(packageService.readPackageDetail(packageId));
    debugPrint('Refreshed');
  }

  getPackageHistory() {
    listPackageHistory(packageService.readPackageHistory(
        authController.uid(), authController.role()));
    debugPrint('Refreshed');
  }

  getPackage() {
    listPackage(packageService.readPackage(
        authController.uid(), authController.role()));
    debugPrint('Refreshed');
  }

  Future setController(packageId) async {
    var response =
        await packageService.readPackageDetail(packageId).whenComplete(
              () => Get.back(),
            );
    if (response[0] == 200) {
      textCtrlNoResi.text = response[2][0]['noresi'];
      textCtrlName.text = response[2][0]['name'];
      textCtrlStreet.text = response[2][0]['street_name'];
      textCtrlBuildingName.text = response[2][0]['building_name'];
      textCtrlRoomNum.text = response[2][0]['room_number'];
      Get.toNamed('/package/form',
          parameters: {'isEdit': 'true', 'packageId': packageId});
    } else if (response[0] == 404) {
      return Get.snackbar("Error", response[1]);
    } else {
      return Get.snackbar("Error", response);
    }
  }

  Future completePackage(packageId) async {
    var response = await packageService
        .updatePackageReceivedStatus(packageId)
        .whenComplete(
          () => Get.back(),
        );
    if (response[0] == 200) {
      getPackage();
      getPackageHistory();
      Get.back();
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        return Get.snackbar("Success", response[1]);
      });
    } else if (response[0] == 404) {
      return Get.snackbar("Error", response[1]);
    } else {
      return Get.snackbar("Error", response);
    }
  }

  Future returnPackage(packageId) async {
    var response =
        await packageService.updatePackageReturnStatus(packageId).whenComplete(
              () => Get.back(),
            );

    if (response[0] == 200) {
      getPackage();
      Get.back();
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        return Get.snackbar("Success", response[1]);
      });
    } else if (response[0] == 404) {
      return Get.snackbar("Error", response[1]);
    } else {
      return Get.snackbar("Error", response);
    }
  }

  Future inputForm(context, isEdit, packageId) async {
    var response;
    if (authController.role() == 1) {
      // do nothing
    } else if (authController.role() == 2) {
      response = await packageService
          .updatePackageStatusByAdmin(
            authController.uid(),
            textCtrlNoResi.text,
            textCtrlName.text,
            textCtrlStreet.text,
            textCtrlBuildingName.text,
            textCtrlRoomNum.text,
          )
          .whenComplete(
            () => Get.back(),
          );
    } else if (authController.role() == 3) {
      if (!isEdit) {
        response = await packageService
            .inputPackage(
              authController.uid(),
              textCtrlNoResi.text,
              textCtrlName.text,
              textCtrlStreet.text,
              textCtrlBuildingName.text,
              textCtrlRoomNum.text,
            )
            .whenComplete(
              () => Get.back(),
            );
      } else {
        response = await packageService
            .updatePackage(
              packageId,
              textCtrlNoResi.text,
              textCtrlName.text,
              textCtrlStreet.text,
              textCtrlBuildingName.text,
              textCtrlRoomNum.text,
            )
            .whenComplete(
              () => Get.back(),
            );
        getPackageDetail(packageId);
      }
    }

    clearTextCtrl();
    if (response[0] == 200) {
      getPackage();
      if (authController.role() == 2) {
        Get.dialog(
          checkResident(response[0], '', this),
        );

        Get.back();
      } else {
        Get.back();
        Future.delayed(const Duration(milliseconds: 500)).then((value) {
          return Get.snackbar("Success", response[1]);
        });
      }
    } else if (response[0] == 404) {
      if (authController.role() == 2) {
        Get.dialog(
          checkResident(response[0], response[2]['id_package'], this),
        );
      } else {
        return Get.snackbar("Error", response[1]);
      }
    } else {
      return Get.snackbar("Error", response);
    }
  }

  String? validateTextCtrl(String? value) {
    if (value == null || value.isEmpty || value == "" || value == " ") {
      return "Can't be empty";
    }
    return null;
  }

  void clearTextCtrl() {
    textCtrlNoResi.clear();
    textCtrlName.clear();
    textCtrlStreet.clear();
    textCtrlBuildingName.clear();
    textCtrlRoomNum.clear();
  }

  void setControllerData(data) async {
    textCtrlNoResi.text = data['resi'];
    textCtrlName.text = data['recipient'];
    textCtrlStreet.text = data['address'];
    textCtrlBuildingName.text = data['building'];
    textCtrlRoomNum.text = data['room'];
    Get.toNamed('/package/form', parameters: {'isEdit': 'false'});
  }
}
