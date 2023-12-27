// ignore_for_file: todo

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreenController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer.periodic(const Duration(milliseconds: 200), (timer) {
        splashProgress.value += 0.1;
        if (splashProgress >= 1) {
          timer.cancel();
          Get.offNamed('/auth');
        }
      });
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // Declare Variable

  RxDouble splashProgress = 0.0.obs;

  // Declare Func
}
