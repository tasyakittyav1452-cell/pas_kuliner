
import '../data/food_data.dart';
import '../models/food_model.dart';

class FoodController {
  // Mengambil seluruh daftar makanan.
  List<FoodModel> getFoods() {
    return foodList;
  }

  // Mengambil satu makanan berdasarkan indeks.
  FoodModel getFoodByIndex(int index) {
    return foodList[index];
  }
}
