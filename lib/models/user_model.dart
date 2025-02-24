class UserModel {
  final int id;
  final String username;
  final String name;
  final String email;
  final String contactNumber;
  final String password;
  final int numberOfSystems;
  final String location;
  final String role;
  final String status;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.password,
    required this.numberOfSystems,
    required this.location,
    required this.role,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      contactNumber: json['contact_number'],
      password: json['password'],
      numberOfSystems: json['number_of_systems'],
      location: json['location'],
      role: json['role'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'contact_number': contactNumber,
      'password': password,
      'number_of_systems': numberOfSystems,
      'location': location,
      'role': role,
      'status': status,
    };
  }
}
