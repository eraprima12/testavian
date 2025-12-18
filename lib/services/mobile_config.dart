import 'package:dio/dio.dart';
import '../models/mobile_config.dart';
import '../network/dio_client.dart';

class MobileConfigService {
  final Dio _dio = DioClient.dio;

  Future<List<MobileConfig>> getAll() async {
    final res = await _dio.get('/mobile-config');
    return (res.data as List).map((e) => MobileConfig.fromJson(e)).toList();
  }

  Future<List<MobileConfig>> getByBranch(String branchCode) async {
    final res = await _dio.get('/mobile-config/by-branch/$branchCode');
    return (res.data as List).map((e) => MobileConfig.fromJson(e)).toList();
  }
}
