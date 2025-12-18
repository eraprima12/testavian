class CustomerTTH {
  final int id;
  final String tthNo;
  final String salesId;
  final String ttotTpNo;
  final String custId;
  final String docDate;
  final int received;

  CustomerTTH({
    required this.id,
    required this.tthNo,
    required this.salesId,
    required this.ttotTpNo,
    required this.custId,
    required this.docDate,
    required this.received,
  });

  factory CustomerTTH.fromJson(Map<String, dynamic> json) {
    return CustomerTTH(
      id: json['ID'],
      tthNo: json['TTHNo'],
      salesId: json['SalesID'],
      ttotTpNo: json['TTOTTPNo'],
      custId: json['CustID'],
      docDate: json['DocDate'],
      received: json['Received'],
    );
  }
}
