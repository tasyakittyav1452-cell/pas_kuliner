
import 'package:flutter/material.dart';
import '../models/food_model.dart';

class TransactionPage extends StatefulWidget {
  // Menerima data makanan dari halaman Home.
  final FoodModel food;

  const TransactionPage({
    super.key,
    required this.food,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  // Mengatur input jumlah pesanan.
  final quantityController = TextEditingController(text: '1');

  // Menyimpan jumlah pesanan.
  int quantity = 1;

  // Menghitung subtotal harga makanan.
  int get subtotal => widget.food.price * quantity;

  // Menghitung PPN sebesar 5%.
  int get ppn => (subtotal * 0.05).round();

  // Menghitung total pembayaran.
  int get total => subtotal + ppn;

  // Mengubah angka menjadi format Rupiah.
  String formatRupiah(int price) {
    return 'Rp${price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
    )}';
  }

  // Memperbarui jumlah pesanan dari input pengguna.
  void updateQuantity(String value) {
    final newQuantity = int.tryParse(value);

    setState(() {
      quantity = newQuantity != null && newQuantity > 0
          ? newQuantity
          : 1;
    });
  }

  @override
  void dispose() {
    // Membersihkan controller input.
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Makanan'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan nama makanan.
            Text(
              widget.food.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Harga: ${formatRupiah(widget.food.price)}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 25),

            // Input jumlah pesanan.
            const Text(
              'Jumlah Pesanan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan jumlah pesanan',
              ),
              onChanged: updateQuantity,
            ),

            const SizedBox(height: 30),

            // Menampilkan rincian pembayaran.
            const Text(
              'Rincian Pembayaran',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            paymentRow('Subtotal', formatRupiah(subtotal)),
            paymentRow('PPN (5%)', formatRupiah(ppn)),

            const Divider(height: 30),

            paymentRow(
              'Total Pembayaran',
              formatRupiah(total),
              isBold: true,
            ),

            const Spacer(),

            // Tombol menyelesaikan transaksi.
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Transaksi berhasil dihitung!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Selesaikan Transaksi'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Membuat baris informasi pembayaran.
  Widget paymentRow(
      String title,
      String value, {
        bool isBold = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
