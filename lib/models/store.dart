class StoreModel {
  final int custId;
  final String storeName;
  final String status;
  final List<DocumentModel> documents;

  StoreModel({
    required this.custId,
    required this.storeName,
    required this.status,
    required this.documents,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      custId: json['cust_id'],
      storeName: json['store_name'],
      status: json['status'],
      documents: (json['documents'] as List)
          .map((e) => DocumentModel.fromJson(e))
          .toList(),
    );
  }
}

class DocumentModel {
  final String docNo;
  final String date;

  DocumentModel({required this.docNo, required this.date});

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      docNo: json['doc_no'],
      date: json['date'],
    );
  }
}
