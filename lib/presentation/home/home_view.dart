import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:testavian/app_colors.dart';
import 'package:testavian/presentation/home/home_controller.dart';
import 'package:testavian/presentation/home/widget/popup__gift_total.dart';
import 'package:testavian/presentation/home/widget/popup_confirm.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F7),
      //! APPBAR Dibuat seperti ini karena menurut saya lebih clean dan estetik,
      //! dan peletakan Dropdown dan tombol total hadiah lebih estetik ketika appbar diberi warna primary
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0E7C6B),
        title: Obx(() {
          return DropdownButton<String>(
            underline: const SizedBox(),
            dropdownColor: AppColors.primary,
            iconEnabledColor: Colors.white,
            value: controller.storeFilter.value,
            items: controller.customerNamesAggregate
                .map((name) => DropdownMenuItem(
                      value: name,
                      child: Text(
                        name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                controller.setStoreFilter(value);
              }
            },
          );
        }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7A00),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                showTotalHadiahPopup(controller);
              },
              icon: const Icon(Icons.card_giftcard),
              label: const Text(
                'Total Hadiah',
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Text(controller.errorMessage.value!),
          );
        }

        if (controller.customers.isEmpty) {
          return const Center(child: Text('Data tidak tersedia'));
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.customers.length,
            itemBuilder: (context, index) {
              final customer = controller.customers[index];
              //! Container ListTTH toko dibuat seperti ini karena lebih simple dan mudah untuk di notice pengguna awam
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                customer.customerName ?? '-',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_pin,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    customer.address ?? '-',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              customer.status ?? '-',
                              style: TextStyle(
                                color: customer.status == 'Sudah Diberikan'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 12,
                                  color: Colors.grey,
                                ),
                                Text(
                                  customer.phone ?? '-',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...customer.vouchers.map(
                      (voucher) => GestureDetector(
                        onTap: () {
                          Logger().f(customer.status);
                          if (customer.status != 'Sudah Diberikan') {
                            showConfirmTerima(
                                custId: customer.customerId!,
                                controller: controller);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0E7C6B),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.card_giftcard,
                                  color: Colors.orange),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  voucher.ttolNo ?? '-',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (voucher.received)
                                const Icon(Icons.check_circle,
                                    color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
