import 'package:testavian/models/home_customer.dart';
import 'package:testavian/models/home_tth.dart';

class HomeResponse {
  final List<HomeCustomer> customers;
  final List<HomeTTHModel> tthDetails;

  HomeResponse({
    required this.customers,
    required this.tthDetails,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      customers: (json['customer_data'] as List)
          .map((e) => HomeCustomer.fromJson(e))
          .toList(),
      tthDetails: (json['tth_detail'] as List)
          .map((e) => HomeTTHModel.fromJson(e))
          .toList(),
    );
  }
}
