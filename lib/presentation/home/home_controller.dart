import 'package:get/get.dart';
import 'package:testavian/models/customer_tth_detail.dart';
import 'package:testavian/models/home_customer.dart';
import 'package:testavian/models/home_tth.dart';
import 'package:testavian/services/bff_home.dart';
import 'package:testavian/services/customer_tth_detail.dart';

class HomeController extends GetxController {
  final BFFHome _service = BFFHome();
  final CustomerTTHDetailService _tthDetailService = CustomerTTHDetailService();

  final isLoading = false.obs;
  final errorMessage = RxnString();

  final customers = <HomeCustomer>[].obs;
  final allCustomers = <HomeCustomer>[].obs;
  RxList<String> customerNamesAggregate = <String>[].obs;

  final rawCustomersTTHDetail = <CustomerTTHDetail>[].obs;
  final List<HomeTTHModel> homeTTH = <HomeTTHModel>[].obs;

  final storeFilter = 'Semua Toko'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHome();
    fetchTTHDetail();
  }

  Future<void> fetchTTHDetail() async {
    final result = await _tthDetailService.getTth();
    homeTTH.assignAll(groupingTTHDetail(result));
  }

  List<HomeTTHModel> groupingTTHDetail(List<CustomerTTHDetail> data) {
    Map<String, Map<String, dynamic>> grouped = {};

    for (var item in data) {
      String jenis = item.jenis;
      if (grouped.containsKey(jenis)) {
        grouped[jenis]!['total'] += item.qty;
      } else {
        grouped[jenis] = {'jenis': jenis, 'total': item.qty, 'unit': item.unit};
      }
    }

    List<Map<String, dynamic>> result = grouped.values.toList();
    return (result).map((e) => HomeTTHModel.fromJson(e)).toList();
  }

  Future<void> fetchHome() async {
    try {
      isLoading(true);
      errorMessage.value = null;

      final result = await _service.getHomeData();

      allCustomers.assignAll(result);
      customerNamesAggregate.value = (['Semua Toko'] +
          allCustomers.map((c) => c.customerName!).toSet().toList());

      applyFilter();
    } catch (e) {
      errorMessage.value = 'Gagal memuat data';
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshData() async {
    await fetchHome();
  }

  void setStoreFilter(String value) {
    storeFilter.value = value;
    applyFilter();
  }

  void applyFilter() {
    if (storeFilter.value == 'Semua Toko' || storeFilter.value.isEmpty) {
      customers.assignAll(allCustomers);
    } else {
      customers.assignAll(
        allCustomers.where(
          (c) => (c.customerName ?? '')
              .toLowerCase()
              .contains(storeFilter.value.toLowerCase()),
        ),
      );
    }
  }

  int get totalCustomers => allCustomers.length;

  // Map<String, int> get totalHadiah {
  //   final Map<String, int> result = {};

  //   for (final customer in allCustomers) {
  //     for (final v in customer.vouchers) {
  //       final key = v.received.toString();
  //       result[key] = (result[key] ?? 0) + 1;
  //     }
  //   }

  //   return result;
  // }

  Future<void> confirmTerima(String custId) async {
    try {
      isLoading(true);
      await _service.confirmStore(
        custId: custId,
        action: 'TERIMA',
      );
      await fetchHome();
    } catch (_) {
      errorMessage.value = 'Gagal konfirmasi terima';
    } finally {
      isLoading(false);
    }
  }

  Future<void> confirmTolak(String custId, String reason) async {
    try {
      isLoading(true);
      await _service.confirmStore(
        custId: custId,
        action: 'TOLAK',
        reason: reason,
      );
      await fetchHome();
    } catch (_) {
      errorMessage.value = 'Gagal konfirmasi tolak';
    } finally {
      isLoading(false);
    }
  }
}
