
import 'package:flutter/material.dart';
import '../controllers/food_controller.dart';
import '../models/food_model.dart';
import 'transaction_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Membuat objek controller makanan.
  static final FoodController foodController = FoodController();

  // Mengubah angka menjadi format Rupiah.
  String formatRupiah(int price) {
    return 'Rp${price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil data makanan dari controller.
    final List<FoodModel> foods = foodController.getFoods();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Kuliner'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),

      // Menampilkan daftar makanan.
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade100,
                child: const Icon(
                  Icons.restaurant,
                  color: Colors.orange,
                ),
              ),
              title: Text(
                food.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(formatRupiah(food.price)),
              trailing: const Icon(Icons.arrow_forward_ios),

              // Membuka halaman transaksi sesuai makanan yang dipilih.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionPage(
                      food: food,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
