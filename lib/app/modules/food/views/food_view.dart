import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/food_controller.dart';

class FoodView extends GetView<FoodController> {
  FoodView({Key? key}) : super(key: key);

  final FoodController controller = Get.put(FoodController());
  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Menu'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  labelText: 'Enter food', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.searchFood(searchController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F3826), // Warna hijau
                minimumSize: const Size(double.infinity, 48), // Ukuran tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8), // Radius yang sama dengan TextField
                ),
              ),
              child: const Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Results:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF1F3826),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Obx(() {
                  // Tampilkan hasil pencarian
                  if (controller.searchResults.isEmpty) {
                    return const Center(
                      child: Text(
                      'No results found',
                      style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      final food = controller.searchResults[index];
                      final calories = food['calories'] != null
                          ? '${food['calories']} cal' // Tambahkan "cal"
                          : '0 cal'; // Jika tidak ada data, tampilkan default
                      final weight = food['weight'] != null
                          ? '${food['weight']} g' // Tambahkan "g"
                          : 'No weight';
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            // Placeholder untuk gambar
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade300,
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/food.jpg'), // Ganti dengan gambar Anda
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                                width: 12), // Pindahkan di luar Container
                            // Informasi makanan
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food['name'] ?? 'Unknown',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$calories | $weight',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
