import 'package:get/get.dart';
import 'package:skripsi_kos_app/sources/modules/controllers/url_launcher.controller.dart';

import 'sources/modules/controllers/controllers.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}

class NavBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => NavController(), fenix: true);
  }
}

class TextScannerBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => TextScannerController(), fenix: true);
  }
}

class FilePickerBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => FilePickerController(), fenix: true);
  }
}

class UrlLaunchierBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => UrlLauncherController(), fenix: true);
  }
}

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => SplashScreenController(), fenix: true);
  }
}

class ResidentBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => ResidentController(), fenix: true);
  }
}

class PackageBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => PackageController(), fenix: true);
  }
}
