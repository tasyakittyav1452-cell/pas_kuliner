
class TeamModel {
  // Menyimpan informasi tim sepak bola.
  final String name;
  final String badge;
  final String stadium;

  // Membuat objek data tim.
  TeamModel({
    required this.name,
    required this.badge,
    required this.stadium,
  });

  // Mengubah data JSON menjadi objek TeamModel.
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      name: json['strTeam'] ?? 'Nama tidak tersedia',
      badge: json['strBadge'] ?? '',
      stadium: json['strStadium'] ?? 'Stadion tidak tersedia',
    );
  }
}
