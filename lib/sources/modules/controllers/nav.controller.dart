import 'package:get/get.dart';
import 'controllers.dart';

class NavController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ctrlAuth.getPref();
    ctrlAuth.getProfile(ctrlAuth.uid(), ctrlAuth.role());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  final ctrlAuth = Get.find<AuthController>();
  final ctrlPackage = Get.find<PackageController>();
  Rx<int> selectedIndex = 0.obs;

  Rx<Future> futureNotif = Future.value().obs;
}
