import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../themes/colors/colors.dart';
import '../../../../widgets/widgets.dart';
import '../../controllers/controllers.dart';
import '../views.dart';

class PostmanHomeView extends GetView<NavController> {
  const PostmanHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ReText(
            text: 'WELCOME, Postman',
            isHeading: true,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: ColorsTheme.primary,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 2,
            color: ColorsTheme.primary,
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ReText(
                text: 'On Going',
                isHeading: true,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsTheme.primary,
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  controller.ctrlPackage.getPackage();
                },
                icon: const Icon(
                  Icons.refresh,
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => packageList(
                controller.ctrlPackage.listPackage(),
                true,
                false,
                3,
                controller,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ReText(
                text: 'History',
                isHeading: true,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsTheme.primary,
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  controller.ctrlPackage.getPackageHistory();
                },
                icon: const Icon(
                  Icons.refresh,
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => packageList(
                controller.ctrlPackage.listPackageHistory(),
                true,
                true,
                3,
                controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
