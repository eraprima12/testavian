class HomeTTHModel {
  final String name;
  final int total;
  final String unit;

  HomeTTHModel({
    required this.name,
    required this.total,
    required this.unit,
  });

  factory HomeTTHModel.fromJson(Map<String, dynamic> json) {
    return HomeTTHModel(
      name: json['jenis'] ?? '',
      total: json['total'] ?? 0,
      unit: json['unit'] ?? '',
    );
  }
}
