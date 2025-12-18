import 'package:dio/dio.dart';
import '../models/customer_tth.dart';
import '../network/dio_client.dart';

class CustomerTTHService {
  final Dio _dio = DioClient.dio;

  Future<List<CustomerTTH>> getAll() async {
    final res = await _dio.get('/customer-tth');
    return (res.data as List).map((e) => CustomerTTH.fromJson(e)).toList();
  }

  Future<List<CustomerTTH>> getByCustomer(String custId) async {
    final res = await _dio.get('/customer-tth/by-customer/$custId');
    return (res.data as List).map((e) => CustomerTTH.fromJson(e)).toList();
  }
}
