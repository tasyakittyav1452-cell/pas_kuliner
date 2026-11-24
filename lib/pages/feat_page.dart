
import 'package:flutter/material.dart';
import '../controllers/team_controller.dart';
import '../models/team_model.dart';

class FeatPage extends StatefulWidget {
  const FeatPage({super.key});

  @override
  State<FeatPage> createState() => _FeatPageState();
}

class _FeatPageState extends State<FeatPage> {
  // Membuat objek TeamController.
  final TeamController teamController = TeamController();

  // Menyimpan proses pengambilan data tim.
  late Future<List<TeamModel>> futureTeams;

  @override
  void initState() {
    super.initState();

    // Mengambil data ketika halaman pertama kali dibuka.
    futureTeams = teamController.getTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Premier League'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),

      // Menunggu data dari API.
      body: FutureBuilder<List<TeamModel>>(
        future: futureTeams,
        builder: (context, snapshot) {
          // Menampilkan loading selama data diambil.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          }

          // Menampilkan pesan jika terjadi kesalahan.
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          // Mengambil hasil data tim.
          final teams = snapshot.data ?? [];

          // Menampilkan pesan jika data kosong.
          if (teams.isEmpty) {
            return const Center(
              child: Text('Data tim tidak ditemukan.'),
            );
          }

          // Menampilkan daftar tim menggunakan ListView.builder.
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  // Menampilkan logo tim.
                  leading: team.badge.isNotEmpty
                      ? Image.network(
                    team.badge,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.sports_soccer,
                        size: 40,
                      );
                    },
                  )
                      : const Icon(
                    Icons.sports_soccer,
                    size: 40,
                  ),

                  // Menampilkan nama tim.
                  title: Text(
                    team.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Menampilkan nama stadion.
                  subtitle: Text(
                    'Stadion: ${team.stadium}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
