import 'package:dio/dio.dart';
import '../models/customer_tth_detail.dart';
import '../network/dio_client.dart';

class CustomerTTHDetailService {
  final Dio _dio = DioClient.dio;

  Future<List<CustomerTTHDetail>> getTth() async {
    final res = await _dio.get('/customer-tth-detail/');
    return (res.data['data'] as List)
        .map((e) => CustomerTTHDetail.fromJson(e))
        .toList();
  }

  Future<List<CustomerTTHDetail>> getByTthNo(String tthNo) async {
    final res = await _dio.get('/customer-tth-detail/by-tth/$tthNo');
    return (res.data as List)
        .map((e) => CustomerTTHDetail.fromJson(e))
        .toList();
  }
}
