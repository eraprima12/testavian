import 'home_voucher.dart';

class HomeCustomer {
  final String? customerId;
  final String? customerName;
  final String? address;
  final String? phone;
  final String? status;
  final List<HomeVoucher> vouchers;

  HomeCustomer({
    this.customerId,
    this.customerName,
    this.address,
    this.phone,
    this.status,
    required this.vouchers,
  });

  factory HomeCustomer.fromJson(Map<String, dynamic> json) {
    return HomeCustomer(
      customerId: json['customer_id'] as String?,
      customerName: json['customer_name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      status: json['status'] as String?,
      vouchers: (json['vouchers'] as List<dynamic>? ?? [])
          .map((e) => HomeVoucher.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'customer_name': customerName,
      'address': address,
      'phone': phone,
      'status': status,
      'vouchers': vouchers.map((e) => e.toJson()).toList(),
    };
  }
}
