class MobileConfig {
  final String key;
  final String value;

  MobileConfig({
    required this.key,
    required this.value,
  });

  factory MobileConfig.fromJson(Map<String, dynamic> json) {
    return MobileConfig(
      key: json['Key'] ?? '',
      value: json['Value'] ?? '',
    );
  }

  List<String> get parsedItems {
    if (value.isEmpty) return [];
    return value
        .split('|')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
}
