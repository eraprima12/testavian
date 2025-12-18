class HomeVoucher {
  final String? ttolNo;
  final String? docDate;
  final bool received;

  HomeVoucher({
    this.ttolNo,
    this.docDate,
    required this.received,
  });

  factory HomeVoucher.fromJson(Map<String, dynamic> json) {
    return HomeVoucher(
      ttolNo: json['ttol_no'] as String?,
      docDate: json['doc_date'] as String?,
      received: json['received'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ttol_no': ttolNo,
      'doc_date': docDate,
      'received': received,
    };
  }
}
