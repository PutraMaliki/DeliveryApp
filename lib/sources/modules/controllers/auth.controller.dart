import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/services.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPref();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    textCtrlName().dispose();
    textCtrlEmail().dispose();
    textCtrlPassword().dispose();

    textCtrlSurname().dispose();

    textCtrlBuilding().dispose();
    textCtrlStreet().dispose();
    textCtrlBiography().dispose();
  }

  // Variable

  AuthService authService = AuthService();

  final box = GetStorage();
  Rx<String> uid = "".obs;
  Rx<bool> session = false.obs;
  Rx<int> role = 0.obs;
  Rx<String> buildingId = "".obs;

  Rx<Future> profile = Future.value().obs;

  Rx<TextEditingController> textCtrlName = TextEditingController().obs;
  Rx<TextEditingController> textCtrlEmail = TextEditingController().obs;
  Rx<TextEditingController> textCtrlPassword = TextEditingController().obs;

  Rx<TextEditingController> textCtrlSurname = TextEditingController().obs;

  Rx<TextEditingController> textCtrlBuilding = TextEditingController().obs;
  Rx<TextEditingController> textCtrlStreet = TextEditingController().obs;
  Rx<TextEditingController> textCtrlBiography = TextEditingController().obs;

  // Function
  void setPref(String uid, bool session, int role, String buildingId) async {
    box.write('uid', uid);
    box.write('session', session);
    box.write('role', role);
    box.write('buildingID', buildingId);

    debugPrint(
        "Uid: $uid\nSession: $session\nRole: $role\nBuilding ID: $buildingId");
  }

  void getPref() async {
    uid(box.read('uid'));
    session(box.read('session'));
    role(box.read('role'));
    buildingId(box.read('buildingID'));

    debugPrint(
        "Uid: $uid\nSession: $session\nRole: $role\nBuilding ID: $buildingId");
  }

  Future signIn() async {
    var response;
    String encrypted = encryptPassword(
      textCtrlPassword().text.trim(),
    );

    response = await authService
        .signIn(
          role(),
          textCtrlEmail().text.trim(),
          role() != 1 ? encrypted.trim() : textCtrlPassword().text.trim(),
        )
        .whenComplete(
          () => Get.back(),
        );

    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      if (response[0] == 200) {
        session(true);
        uid(response[2]['id']);
        buildingId(response[2]['building_id']);
        setPref(uid(), session(), role(), buildingId());

        if (role() == 1) {
          Get.offAllNamed('/user/nav');
        } else if (role() == 3) {
          Get.offAllNamed('/postman/nav');
        } else {
          Get.offAllNamed('/admin/nav');
        }
      } else if (response[0] == 404) {
        return Get.snackbar("Error", response[1]);
      } else {
        return Get.snackbar("Error", response);
      }
    });

    debugPrint(
        "Uid: $uid\nSession: $session\nRole: $role\nBuilding ID: $buildingId");
  }

  Future signUp() async {
    var response;
    String encrypted = encryptPassword(
      textCtrlPassword().text.trim(),
    );

    if (role() == 1) {
      // User Not Sign Up
    } else if (role() == 3) {
      response = await authService
          .signUpPostman(
            textCtrlName().text.trim(),
            textCtrlEmail().text.trim(),
            encrypted.trim(),
          )
          .whenComplete(
            () => Get.back(),
          );
    } else {
      response = await authService
          .signUpAdmin(
            textCtrlName().text.trim(),
            textCtrlEmail().text.trim(),
            encrypted.trim(),
            textCtrlBuilding().text.trim(),
            textCtrlStreet().text.trim(),
            textCtrlBiography().text.trim(),
          )
          .whenComplete(
            () => Get.back(),
          );
    }

    Future.delayed(
      const Duration(milliseconds: 500),
    ).then((value) {
      if (response[0] == 200) {
        session(true);
        uid(response[2]['id']);
        buildingId(response[2]['building_id']);
        setPref(uid(), session(), role(), buildingId());
        if (role() == 1) {
          // User Not Sign Up
        } else if (role() == 3) {
          Get.offAllNamed('/postman/nav');
        } else {
          Get.offAllNamed('/admin/nav');
        }
      } else if (response[0] == 404) {
        return Get.snackbar("Error", response[1]);
      } else {
        return Get.snackbar("Error", response);
      }
    });
    debugPrint(
        "Uid: $uid\nSession: $session\nRole: $role\nBuilding ID: $buildingId");
  }

  Future signOut() async {
    uid("");
    session(false);
    role(0);
    buildingId("");
    setPref(uid(), session(), role(), buildingId());
    debugPrint(
        "Uid: $uid\nSession: $session\nRole: $role\nBuilding ID: $buildingId");

    Get.offAllNamed('/auth');
  }

  List<String> generateSalt(value) {
    int length = value.length;
    int halfLength = (length / 2).ceil();

    String firstHalf = value.substring(0, halfLength);
    String secondHalf = value.substring(halfLength);

    String reversedFirstHalf =
        String.fromCharCodes(firstHalf.runes.toList().reversed);
    String reversedSecondHalf =
        String.fromCharCodes(secondHalf.runes.toList().reversed);

    return [reversedFirstHalf, reversedSecondHalf];
  }

  String encryptPassword(value) {
    String fSalt = generateSalt(value)[0];
    String rSalt = generateSalt(value)[1];
    var bytes = utf8.encode(rSalt + value + fSalt);
    var digest = sha256.convert(bytes);
    String encrypted = digest.toString();

    return encrypted;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future getProfile(uid, role) async {
    profile(
      authService.getProfile(uid, role),
    ).obs;
  }

  void setControllerProfile(data) {
    textCtrlName().text = data['name'];
    textCtrlEmail().text = data['email'];
    textCtrlPassword().text = data['password'];
    if (role() == 1) {
      textCtrlSurname().text = data['surname'];
    }
    if (role() == 2) {
      textCtrlBuilding().text = data['building_name'];
      textCtrlStreet().text = data['address'];
      textCtrlBiography().text = data['biography'];
    }
  }

  Future updateProfile() async {
    var response;
    if (role() == 1) {
      response = await authService
          .updateProfileResident(
            uid(),
            textCtrlName().text,
            textCtrlSurname().text,
            textCtrlEmail().text,
            textCtrlPassword().text,
          )
          .whenComplete(
            () => Get.back(),
          );
    } else if (role() == 2) {
      response = await authService
          .updateProfileAdmin(
            uid(),
            buildingId(),
            textCtrlName().text,
            textCtrlEmail().text,
            textCtrlPassword().text,
            textCtrlBuilding().text,
            textCtrlStreet().text,
            textCtrlBiography().text,
          )
          .whenComplete(
            () => Get.back(),
          );
    } else if (role() == 3) {}
    response = await authService
        .updateProfilePostman(
          uid(),
          textCtrlName().text,
          textCtrlEmail().text,
          textCtrlPassword().text,
        )
        .whenComplete(
          () => Get.back(),
        );

    if (response[0] == 200) {
      getProfile(uid, role);
      return Get.snackbar("Success", response[1]);
    } else if (response[0] == 404) {
      return Get.snackbar("Error", response[1]);
    } else {
      return Get.snackbar("Error", response);
    }
  }

  RxBool isVisible = true.obs;

  void passwordVisibility() {
    isVisible(!isVisible());
  }
}
