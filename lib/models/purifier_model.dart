class Purifier {
  final int id;
  final int serialno;
  final String name;
  final String location;
  final String status;
  final String manufactureDate;
  final int salesOrderNumber;
  final int user;

  Purifier({
    required this.id,
    required this.serialno,
    required this.name,
    required this.location,
    required this.status,
    required this.manufactureDate,
    required this.salesOrderNumber,
    required this.user,
  });

  factory Purifier.fromJson(Map<String, dynamic> json) {
    return Purifier(
      id: json['id'],
      serialno: int.tryParse(json['serial_number'].toString()) ?? 0,
      name: json['purifier_name'],
      location: json['location'],
      status: json['status'],
      manufactureDate: json['manufacture_date'],
      salesOrderNumber: int.tryParse(json['sales_order_number'].toString()) ?? 0,
      user: json['user'],
    );
  }
}
