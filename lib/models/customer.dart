class Customer {
  final String custId;
  final String name;
  final String address;
  final String branchCode;
  final String phoneNo;

  Customer({
    required this.custId,
    required this.name,
    required this.address,
    required this.branchCode,
    required this.phoneNo,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      custId: json['CustID'],
      name: json['Name'],
      address: json['Address'],
      branchCode: json['BranchCode'],
      phoneNo: json['PhoneNo'],
    );
  }
}
