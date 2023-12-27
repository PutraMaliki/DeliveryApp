import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripsi_kos_app/sources/modules/controllers/controllers.dart';
import 'package:skripsi_kos_app/sources/services/notification.service.dart';
import 'package:skripsi_kos_app/widgets/text.dart';

class NotificationView extends GetView<NavController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.ctrlAuth.uid);
    return Scaffold(
      appBar: AppBar(
        title: const ReText(
          text: 'Notification',
          isHeading: true,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => controller.futureNotif(
            NotificationService().readNotification(controller.ctrlAuth.uid),
          ),
          child: FutureBuilder(
            future: controller.futureNotif(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List snapData = snapshot.data! as List;
                if (snapData[0] != 404) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: snapData[2].length,
                    itemBuilder: (context, index) {
                      final data = snapData[2][index];
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: ReText(
                                    text: 'Package Id',
                                  ),
                                ),
                                Expanded(
                                  child: ReText(
                                    text: ': ${data['id_package']}',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: ReText(
                                    text: 'Resi No',
                                  ),
                                ),
                                Expanded(
                                  child: ReText(
                                    text: ': ${data['no_resi']}',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: ReText(
                                    text: 'Address',
                                  ),
                                ),
                                Expanded(
                                  child: ReText(
                                    text: ': ${data['street_name']}',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: ReText(
                                    text: 'Status',
                                  ),
                                ),
                                Expanded(
                                  child: ReText(
                                    text: ': ${data['status']}',
                                  ),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Expanded(
                                  child: ReText(
                                    text: 'Message: ',
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox.shrink(),
                                ),
                              ],
                            ),
                            Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: ReText(
                                  text: '${data['message']}',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No Data Found'),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
