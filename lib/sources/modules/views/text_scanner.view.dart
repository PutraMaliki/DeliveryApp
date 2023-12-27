import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/colors/colors.dart';
import '../../../widgets/text.dart';

class TextScannerView extends StatelessWidget {
  const TextScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsTheme.primary,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Get.toNamed('/postman/nav');
            },
            child: const Icon(Icons.arrow_back_outlined)),
        title: const ReText(
          text: 'Result',
          isHeading: true,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: ColorsTheme.onPrimary,
          textAlign: TextAlign.center,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text(
              'Resi no. ${Get.parameters['resi']}',
            ),
            Text(
              'Recipient: ${Get.parameters['recipient']}',
            ),
            Text(
              '${Get.parameters['building']}',
            ),
            Text(
              '${Get.parameters['address']}',
            ),
            Text(
              'Room no. ${Get.parameters['room']}',
            ),
          ],
        ),
      ),
    );
  }
}
