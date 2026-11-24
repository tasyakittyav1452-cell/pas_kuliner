import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main_menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// mengatur seluruh proses dan tampilan halaman login
class _LoginPageState extends State<LoginPage>{
  // controller untuk mengambil input username
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // menentukan apakah proses login sedang berlangsung
  bool isLoading = false;
  // mengatur apakah password disembunyikan atau ditampilkan
  bool obscurePassword = true;

  // untuk melakukan proses login menggunakan REST API
  Future<void> login() async {

    // memeriksa apakah username dan password sudah di isi
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty) {

      // Menampilkan peringatan jika input masih kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan password harus diisi!'),
        ),
      );
      
      return;
    }
    
    // mengubah status loading menjadi aktif
    setState(() {
      isLoading = true;
    });
    
    try {
      
      // mengirim request POST ke endpoint login
      final response = await http.post(
          Uri.parse('https://mediadwi.com/api/latihan/login'),

        // mengirim username dan password ke server
        body: {
            'username': usernameController.text.trim(),
          'password': passwordController.text,
        },
      );

      // mengubah respons JSON dari server menjadi Map
      final data = jsonDecode(response.body);

      // memastikan halaman masih aktif sebelum menggunakan context
      if (!mounted) return;

      // memeriksa apakah login berhasil
      if (response.statusCode == 200 &&
          data is Map &&
          data['status'] == true) {

        // mengarahkan pengguna ke main menu
        // pushreplacement mencegah pengguna kembali ke halaman login
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MainMenu(),
            ),
        );
      } else {

        // menampilkan pesan jika login gagal
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data is Map ?
              data['message']?.toString() ?? 'Login gagal!'
              : 'Login gagal!',
              ),
              backgroundColor: Colors.red,
            ),
        );
      }
    } catch (e) {

      // menampilkan peringatan jika terjadi kesalahan koneksi
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan koneksi ke server!'),
        backgroundColor: Colors.red,
        ),
      );
    } finally {
      // menghentikan indikator loading setelah proses selesai
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // membersihkan controller ketika halaman tidak digunakan
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
