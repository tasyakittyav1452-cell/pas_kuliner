
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Menampilkan foto profil.
              const CircleAvatar(
                radius: 65,
                backgroundColor: Colors.orange,
                child: Icon(
                  Icons.person,
                  size: 75,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // Menampilkan informasi profil.
              const Text(
                'Filzah Zhaafirah Fushshilat Aroky',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Siswa PPLG',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // Card informasi siswa.
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(
                          Icons.school,
                          color: Colors.orange,
                        ),
                        title: Text('Kelas'),
                        subtitle: Text('11 PPLG 3'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.numbers,
                          color: Colors.orange,
                        ),
                        title: Text('Nomor Absen'),
                        subtitle: Text('08'),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.info,
                          color: Colors.orange,
                        ),
                        title: Text('Tentang Saya'),
                        subtitle: Text(
                          'Saya adalah siswa PPLG yang sedang belajar pemrograman'
                              'dan pengembangan aplikasi dengan ide ide yang ada pada otak saya.',
                        ),
                      ),
                    ],
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
