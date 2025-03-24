class Purifier {
  final int id;
  final List<int> users;
  final String systemModelNumber;
  final String serialno;
  final String salesOrderNumber;
  final String name;
  final String manufactureDate;
  final String location;
  final String status;
  final Map<String, bool> configuration;

  Purifier({
    required this.id,
    required this.users,
    required this.systemModelNumber,
    required this.serialno,
    required this.salesOrderNumber,
    required this.name,
    required this.manufactureDate,
    required this.location,
    required this.status,
    required this.configuration,
  });

  factory Purifier.fromJson(Map<String, dynamic> json) {
    final configurations = json['configurations'] as List<dynamic>?;
    Map<String, bool> configMap = {};

    if (configurations != null && configurations.isNotEmpty) {
      final firstConfig = configurations[0] as Map<String, dynamic>;
      configMap = firstConfig.map((key, value) {
        if (value is bool) {
          return MapEntry(key, value);
        } else if (value is int) {
          return MapEntry(key, value != 0); // Convert 0 to false, non-zero to true
        } else {
          throw Exception('Unexpected type for configuration value: ${value.runtimeType}');
        }
      });
      // Remove non-configuration fields
      configMap.remove('id');
      configMap.remove('purifier_id');
    }

    return Purifier(
      id: json['id'] as int,
      users: List<int>.from(json['users'] as List<dynamic>),
      systemModelNumber: json['system_model_number'] as String,
      serialno: json['serial_number'].toString(),
      salesOrderNumber: json['sales_order_number'].toString(),
      name: json['purifier_name'] as String,
      manufactureDate: json['manufacture_date'] as String,
      location: json['location'] as String,
      status: json['status'] as String,
      configuration: configMap,
    );
  }
}