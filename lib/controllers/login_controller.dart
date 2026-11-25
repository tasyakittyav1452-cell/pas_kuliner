import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController {
  // mengatur proses login ke API

  Future<Map<String, dynamic>> login(String username,
      String password,) async {
    try {
// Mengirim username dan password ke API.
      final response = await http.post(
        Uri.parse('https://mediadwi.com/api/latihan/login'),
        body: {
          'username': username,
          'password': password,
        },
      ).timeout(const Duration(seconds: 20));

// Menampilkan respons API di Debug Console.
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response: ${response.body}');

// Mengubah JSON menjadi Map.
      final data = jsonDecode(response.body);

// Memeriksa hasil login.
      if (response.statusCode == 200 &&
          data is Map &&
          data['status'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Login berhasil!',
        };
      }

// Mengembalikan pesan jika login gagal.
      return {
        'success': false,
        'message': data is Map
            ? data['message'] ?? 'Login gagal!'
            : 'Format respons API tidak sesuai!',
      };
    } catch (e) {
// Menampilkan penyebab error sebenarnya.
      debugPrint('Login Error: $e');

      return {
        'success': false,
        'message': 'Gagal menghubungi server: $e',
      };
    }
  }
}