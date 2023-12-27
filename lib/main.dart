import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skripsi_kos_app/sources/modules/views/notification.view.dart';
import 'package:skripsi_kos_app/sources/modules/views/splash.view.dart';

import 'bindings.dart';
import 'sources/modules/views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  setSystemUIOverlayStyle(Colors.white);

  runApp(
    const MainApp(),
  );
}

Future setSystemUIOverlayStyle(final Color color) async {
  // Setting SystemUIMode
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.bottom],
  );

  // Setting SystemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemStatusBarContrastEnforced: true,
      statusBarColor: color.withOpacity(0.002),
      systemNavigationBarColor: color.withOpacity(0.002),
      systemNavigationBarDividerColor: color.withOpacity(0.002),
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Setting Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Skripsi Bebek',
          initialRoute: '/',
          initialBinding: AuthBinding(),
          getPages: [
            GetPage(
              name: '/',
              page: () => const SplashScreenView(),
              binding: SplashScreenBinding(),
            ),
            GetPage(
              name: '/auth',
              page: () => const AuthView(),
              bindings: [
                AuthBinding(),
                NavBinding(),
              ],
            ),
            GetPage(
              name: '/signin',
              page: () => const LoginView(),
            ),
            GetPage(
              name: '/signup',
              page: () => const SignUpView(),
            ),
            GetPage(
              name: '/user/nav',
              page: () => const UserNavigationView(),
              bindings: [
                PackageBinding(),
              ],
            ),
            GetPage(
              name: '/postman/nav',
              page: () => PostmanNavigationView(),
              bindings: [
                PackageBinding(),
                TextScannerBinding(),
                UrlLaunchierBinding(),
              ],
            ),
            GetPage(
              name: '/admin/nav',
              page: () => AdminNavigationView(),
              bindings: [
                PackageBinding(),
                TextScannerBinding(),
                FilePickerBinding(),
              ],
            ),
            GetPage(
              name: '/signup/regis-building',
              page: () => const RegisterBuildingView(),
            ),
            GetPage(
              name: '/admin/resident',
              page: () => const AdminResidentNavigationView(),
              binding: ResidentBinding(),
            ),
            GetPage(
              name: '/package/detail',
              page: () => const DetailTransactionNavigationView(),
            ),
            GetPage(
              name: '/package/form',
              page: () => const FormPageNavigationView(),
            ),
            GetPage(
              name: '/postman/scanner',
              page: () => const TextScannerView(),
            ),
            GetPage(
              name: '/sett',
              page: () => const SettingNavigationView(),
            ),
            GetPage(
              name: '/notif',
              page: () => const NotificationView(),
              binding: NavBinding(),
            ),
          ],
        );
      },
    );
  }
}
