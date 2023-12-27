import 'dart:io';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skripsi_kos_app/sources/modules/controllers/controllers.dart';

import '../../services/services.dart';

class TextScannerController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    textRecognizer.close();
  }

  PackageService packageService = PackageService();
  AuthController authController = AuthController();
  PackageController pkgController = Get.find<PackageController>();

  RxBool isPermissionGranted = false.obs;
  Rx<TextRecognizer> textRecognizer = TextRecognizer().obs;

  final ImagePicker picker = ImagePicker();
  XFile? photo;

  Future grantPermission() async {
    if (!isPermissionGranted()) {
      await Permission.camera.request();
      if (await Permission.camera.isGranted) {
        isPermissionGranted.value = true;
      }
    }
  }

  Future openCamera(context) async {
    grantPermission();
    photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      scanImage(context);
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
      );
    } else {
      Get.snackbar('Error', 'Failed to pick image');
    }
  }

  Future getData(RecognizedText recognizedText) async {
    List<String> text = [];

    RegExp nama = RegExp('name', caseSensitive: false);
    RegExp address = RegExp('address', caseSensitive: false);
    RegExp building = RegExp('building', caseSensitive: false);
    RegExp room = RegExp('room', caseSensitive: false);
    RegExp resi = RegExp('resi', caseSensitive: false);

    var tempName = '';
    var tempAddress = '';
    var tempBuilding = '';
    var tempRoom = '';
    var tempResi = '';

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        text.add(line.text);
      }
    }

    for (var element in text) {
      if (element.contains(nama) && element.contains(':')) {
        var index = element.indexOf(':') + 2;
        tempName = element.substring(index);
      }
      if (element.contains(address) && element.contains(':')) {
        var index = element.indexOf(':') + 2;
        tempAddress = element.substring(index);
      }
      if (element.contains(building) && element.contains(':')) {
        var index = element.indexOf(':') + 2;
        tempBuilding = element.substring(index);
      }
      if (element.contains(room) && element.contains(':')) {
        var index = element.indexOf(':') + 2;
        tempRoom = element.substring(index);
      }
      if (element.contains(resi) && element.contains('.')) {
        var index = element.indexOf('.') + 2;
        tempResi = element.substring(index);
      }
    }

    Map<String, String> data = {
      'recipient': tempName,
      'building': tempBuilding,
      'address': tempAddress,
      'room': tempRoom,
      'resi': tempResi,
    };

    return data;
  }

  Future<void> scanImage(context) async {
    try {
      final file = File(photo!.path);

      final inputImage = InputImage.fromFile(file);

      final recognizedText =
          await textRecognizer().processImage(inputImage).whenComplete(
                () => Get.back(),
              );

      await getData(recognizedText).then((value) {
        pkgController.setControllerData(value);
      });
    } catch (e) {
      Get.snackbar('Error', 'An error occured when scanning text');
    }
  }
}
