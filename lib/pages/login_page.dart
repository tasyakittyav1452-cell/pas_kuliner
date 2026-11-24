import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import 'main_menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // membuat controller untuk mengambil input pengguna.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // memanggil controller login
  final LoginController loginController = LoginController();

  // mengatur kondisi loading dan tampilan password
  bool isLoading = false;
  bool obscurePassword = true;

  // menjalankan proses login
  Future<void> login() async {
    if (usernameController.text.isEmpty ||
    passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password harus diisi!'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    // memanggil fungsi login dari logincontroller
    final result = await loginController.login(
      usernameController.text.trim(),
      passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    // memeriksa hasil login dari controller.
    if (result['success'] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MainMenu(),
        ),
        );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'].toString()),
        backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    // membersihkan controller input ketika halaman ditutup
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant_menu,
                size: 85,
                color: Colors.orange,
              ),
              const SizedBox(height: 15),
              const Text(
                'Aplikasi Kuliner',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Silakan login untuk melanjutkan',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 35),

              // Input username.
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Input password.
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Tombol login.
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}