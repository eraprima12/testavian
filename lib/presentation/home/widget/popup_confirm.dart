import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:testavian/app_colors.dart';
import 'package:testavian/presentation/home/home_controller.dart';
import 'package:testavian/presentation/home/widget/popup_reject_reason.dart';

void showConfirmTerima({
  required String custId,
  required HomeController controller,
}) {
  Get.dialog(
    AlertDialog(
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.center,
      title: const Text(
        'Sudah Terima TTH',
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //! kenapa animasi JSON daripada gambar?
          //! karena lottie itu lightweight, lalu lebih clean jika dipandang visual
          Lottie.asset('assets/lottie/gift.json',
              height: 100, fit: BoxFit.cover),
          const Text(
            'Yakin ingin menyimpan sudah terima TTH?',
            textAlign: TextAlign.center,
          )
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Get.back();
            showConfirmTolak(custId: custId, controller: controller);
          },
          child: const Text(
            'TIDAK',
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            Get.back();
            await controller.confirmTerima(custId);
          },
          child: const Text('YA, SUDAH TERIMA'),
        ),
      ],
    ),
  );
}
