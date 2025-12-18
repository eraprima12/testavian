import 'package:dio/dio.dart';
import 'package:testavian/models/home_customer.dart';
import 'package:logger/logger.dart';
import 'package:testavian/network/dio_client.dart';

class BFFHome {
  final Dio _dio = DioClient.dio;
  Logger logger = Logger();
  Future<List<HomeCustomer>> getHomeData() async {
    try {
      final res = await _dio.get('/bff/home');

      final List list = res.data['data'] as List;

      return list.map((e) {
        logger.f(e.toString());
        return HomeCustomer.fromJson(e);
      }).toList();
    } catch (e) {
      logger.f(e.toString());
      return [];
    }
  }

  Future<void> confirmStore(
      {required String custId, required String action, String? reason}) async {
    await _dio.post('/bff/store/$custId/confirm', data: {
      'action': action,
      'reason': reason,
    });
  }
}
