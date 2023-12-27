import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  RxBool isPermissionGranted = false.obs;


  Future grantPermission() async {
    if (!isPermissionGranted()) {
      await Permission.location.request();
      if (await Permission.location.isGranted) {
        isPermissionGranted.value = true;
      }
    }
  }

  Future<void> uriLaunch(mapUrl) async {
    grantPermission();
    if (!await launchUrl(
      Uri.parse(mapUrl),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $mapUrl');
    }
  }
}
