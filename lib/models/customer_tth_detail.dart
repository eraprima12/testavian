class CustomerTTHDetail {
  final int id;
  final String tthNo;
  final String ttotTpNo;
  final String jenis;
  final int qty;
  final String unit;

  CustomerTTHDetail({
    required this.id,
    required this.tthNo,
    required this.ttotTpNo,
    required this.jenis,
    required this.qty,
    required this.unit,
  });

  factory CustomerTTHDetail.fromJson(Map<String, dynamic> json) {
    return CustomerTTHDetail(
      id: json['ID'],
      tthNo: json['TTHNo'],
      ttotTpNo: json['TTOTTPNo'],
      jenis: json['Jenis'],
      qty: json['Qty'],
      unit: json['Unit'],
    );
  }
}
