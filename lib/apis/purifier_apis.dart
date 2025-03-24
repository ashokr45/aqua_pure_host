import 'dart:convert';
import 'package:aqua_pure/models/purifier_model.dart';
import 'package:http/http.dart' as http;

class PurifierApi {
  static const String baseUrl = 'http://3.82.225.92:8000';

  static Future<List<Purifier>> fetchPurifiers() async {
    final response = await http.get(Uri.parse('$baseUrl/purifier_and_confi/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Purifier.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load purifiers: ${response.statusCode}');
    }
  }

  static Future<dynamic> addPurifier(Map<String, dynamic> purifierData) async {
    final url = Uri.parse('$baseUrl/purifier_and_confi/');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(purifierData),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to add purifier: ${response.statusCode}");
    }
  }

  static Future<dynamic> updatePurifier(int id, Map<String, dynamic> purifierData) async {
    final url = Uri.parse('$baseUrl/purifier_and_confi/$id/');
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(purifierData),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update purifier: ${response.statusCode}");
    }
  }

  static Future<void> deletePurifier(int id) async {
    final url = Uri.parse('$baseUrl/purifier_and_confi/$id/');
    final response = await http.delete(url);
    if (response.statusCode != 204) {
      throw Exception("Failed to delete purifier: ${response.statusCode}");
    }
  }
}