import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testavian/presentation/home/home_controller.dart';

void showConfirmTolak({
  required String custId,
  required HomeController controller,
}) {
  final selectedReason = ''.obs;

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gagal Terima TTH',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Pilih Alasan',
                  border: OutlineInputBorder(),
                ),
                value:
                    selectedReason.value.isEmpty ? null : selectedReason.value,
                items: const [
                  DropdownMenuItem(
                    value: 'Pemilik Sibuk',
                    child: Text('Pemilik Sibuk'),
                  ),
                  DropdownMenuItem(
                    value: 'Toko Tutup',
                    child: Text('Toko Tutup'),
                  ),
                ],
                onChanged: (val) => selectedReason.value = val ?? '',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: Get.back,
                  child: const Text('BATAL'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedReason.value.isEmpty) return;
                    Get.back();
                    await controller.confirmTolak(
                      custId,
                      selectedReason.value,
                    );
                  },
                  child: const Text('SIMPAN'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
