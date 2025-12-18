import 'package:dio/dio.dart';
import '../models/customer.dart';
import '../network/dio_client.dart';

class CustomerService {
  final Dio _dio = DioClient.dio;

  Future<List<Customer>> getCustomers() async {
    final res = await _dio.get('/customers');
    return (res.data as List).map((e) => Customer.fromJson(e)).toList();
  }

  Future<Customer> getCustomerById(String custId) async {
    final res = await _dio.get('/customers/$custId');
    return Customer.fromJson(res.data);
  }
}
