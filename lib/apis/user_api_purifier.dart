import 'dart:convert';
import 'package:aqua_pure/models/user_model.dart';
import 'package:aqua_pure/models/user_model_purifier.dart';
import 'package:http/http.dart' as http;

class UserApi {
  static const String baseUrl = 'http://3.82.225.92:8000';

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }
}