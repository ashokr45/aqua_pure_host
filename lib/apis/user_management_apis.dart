import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'package:aqua_pure/utils/constants/text_strings.dart';

class UserManagementApis {
  
final String baseUrl = TTexts.baseUrl;
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((user) => UserModel.fromJson(user)).toList();
    } else {
      print(response.statusCode);
      debugPrint(response.body);
      throw Exception('Failed to load users');
    }
  }

  Future<UserModel> addUser(UserModel user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'username': user.username,
        'name': user.name,
        'email': user.email,
        'contact_number': user.contactNumber,
        'password': user.password,
        'number_of_systems': user.numberOfSystems,
        'location': user.location,
        'role': user.role,
        'status': user.status,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
        print(response.statusCode);
      throw Exception('Failed to add user');
    }
  }

   // Delete user by email.
  Future<bool> deleteUser(String email) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$email/'));
    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Failed to delete user');
    }
  }

  // Update user by email.
  Future<UserModel> updateUser(String email, UserModel user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$email/'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'username': user.username,
        'name': user.name,
        'contact_number': user.contactNumber,
        'password': user.password,
        'number_of_systems': user.numberOfSystems,
        'location': user.location,
        'role': user.role,
        'status': user.status,
      }),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }
}
