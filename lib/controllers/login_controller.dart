import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginController {
  // mengatur proses login ke API
  Future<Map<String, dynamic>> login(
      String username,
      String password,
      ) async {
    try {
      // mengirim username dan password ke API
      final response = await http.post(
        Uri.parse('https://mediadwi.com/api/latihan/login'),
        body: {
          'username': username,
          'password': password,
        },
      );

      // mengubah JSON dari API menjadi Map.
      final data = jsonDecode(response.body);

      // memeriksa apakah login berhasil.
      if (response.statusCode == 200 &&
      data is Map &&
      data['status'] == true) {
        return {
          'success': true,
          'message': data['message'] ?? 'Login berhasil',
        };
      }

      // mengembalikan pesan jika login gagal
      return {
        'success': false,
        'message': data is Map ? data['message'] ?? 'Login gagal!': 'Login gagal!',
      };
    } catch (e) {
      // menangani kesalahan koneksi atau respons API.
      return {
        'success': false,
        'message': 'Terjadi kesalahan koneksi ke server!',
      };
    }
  }
}