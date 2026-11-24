
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'feat_page.dart';
import 'profile_page.dart';

// Membuat halaman utama dengan navigasi bawah.
class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  // Menyimpan indeks halaman yang sedang dibuka.
  int selectedIndex = 0;

  // Menyimpan daftar halaman aplikasi.
  final List<Widget> pages = const [
    HomePage(),
    FeatPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menampilkan halaman sesuai indeks yang dipilih.
      body: pages[selectedIndex],

      // Membuat navigasi bawah.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Mengubah halaman ketika menu ditekan.
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Feat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
