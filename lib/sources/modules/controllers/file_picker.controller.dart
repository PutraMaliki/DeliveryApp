import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:skripsi_kos_app/sources/modules/controllers/controllers.dart';
import 'package:skripsi_kos_app/sources/services/resident.service.dart';

class FilePickerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ResidentService residentService = ResidentService();
  AuthController authController = Get.find<AuthController>();

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      uploadFile(authController.buildingId(), file.path);
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
    } else {
      return Get.snackbar("Error", "Please try again");
    }
  }

  Future uploadFile(buildingId, file) async {
    var response =
        await residentService.uploadCSV(buildingId, file).whenComplete(
              () => Get.back(),
            );

    if (response[0] == 200) {
      return Get.snackbar("Success", response[1]);
    } else if (response[0] == 404) {
      return Get.snackbar("Error", response[1]);
    } else {
      return Get.snackbar("Error", response);
    }
  }
}
