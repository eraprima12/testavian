import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testavian/presentation/home/home_controller.dart';

void showTotalHadiahPopup(HomeController controller) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.card_giftcard, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      'Total Hadiah',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: Get.back,
                  child: const Icon(Icons.close),
                )
              ],
            ),

            const SizedBox(height: 16),

            Column(
              children: controller.homeTTH
                  .map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(e.name), Text('${e.total} ${e.unit}')],
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 12),

            const Divider(),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Hadiah',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
