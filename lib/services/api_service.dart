
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Menyimpan alamat API English Premier League.
  static const String teamUrl =
      'https://www.thesportsdb.com/api/v1/json/123/search_all_teams.php?l=English%20Premier%20League';

  // Mengambil data seluruh tim dari API.
  Future<List<dynamic>> getTeams() async {
    final response = await http.get(
      Uri.parse(teamUrl),
    );

    // Memeriksa apakah permintaan berhasil.
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Mengambil daftar tim dari respons JSON.
      return data['teams'] ?? [];
    } else {
      throw Exception('Gagal mengambil data tim');
    }
  }
}
