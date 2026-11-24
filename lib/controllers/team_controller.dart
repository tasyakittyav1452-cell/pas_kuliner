
import '../models/team_model.dart';
import '../services/api_service.dart';

class TeamController {
  // Membuat objek API Service.
  final ApiService apiService = ApiService();

  // Mengambil data tim dan mengubahnya menjadi TeamModel.
  Future<List<TeamModel>> getTeams() async {
    final data = await apiService.getTeams();

    // Mengubah setiap data JSON menjadi objek TeamModel.
    return data.map((team) {
      return TeamModel.fromJson(team);
    }).toList();
  }
}
