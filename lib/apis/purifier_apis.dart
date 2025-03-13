import 'dart:convert';
import 'package:aqua_pure/models/purifier_model.dart';
import 'package:http/http.dart' as http;

class PurifierApi {
  static const String baseUrl = 'http://3.82.225.92:8000';

  static Future<List<Purifier>> fetchPurifiers() async {
    final response = await http.get(Uri.parse('$baseUrl/purifiers/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Purifier.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load purifiers');
    }
  }

   static Future addPurifier(Map<String, dynamic> purifierData) async {
    final url = Uri.parse('$baseUrl/purifiers/');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(purifierData),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to add purifier. Error: ${response.statusCode}");
    }
  }
}
