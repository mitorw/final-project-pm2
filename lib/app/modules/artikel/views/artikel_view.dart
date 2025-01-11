import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/home/views/home_view.dart';
import 'package:myapp/app/modules/food/views/food_view.dart';
import 'package:myapp/app/modules/history/views/history_view.dart';

class ArtikelView extends StatelessWidget {
  const ArtikelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003D29),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBE4DA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Artikel",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildArticleCard(
              imageUrl:
                  'https://i.pinimg.com/736x/db/65/76/db6576a4763eae42a8c78d43bb478b21.jpg',
              title:
                  'Senaran kalori Buah-buahan dan sayuran yang sehat untuk kamu !!',
              link: 'https://www.kopas.com',
            ),
            const SizedBox(height: 16),
            _buildArticleCard(
              imageUrl: 'https://via.placeholder.com/300x150',
              title:
                  'Terapkan kebiasaan ini untuk mulai hidup sehat anda sekarang !!',
              link: 'https://www.liputans.com',
            ),
            const SizedBox(height: 16),
            _buildArticleCard(
              imageUrl: 'https://via.placeholder.com/300x150',
              title:
                  'Hindari makanan berikut jika anda ingin hidup lebih sehat !!',
              link: 'https://www.haidos.com',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1F3826),
        selectedItemColor: const Color(0xFF1F3826),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        onTap: (index) async {
          if (index == 0) {
            Get.off(() =>  HomeView());
          }
          if (index == 1) {
            Get.off(() =>  ArtikelView());
          }
          if (index == 2) {
            final selectedFood = await Get.to(() =>  FoodView());
            if (selectedFood != null) {
            }
          }
          if (index == 3) {
            Get.off(() =>  HistoryView());
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.note_alt_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.history_sharp), label: ''),
        ],
      ),
    );
  }

  Widget _buildArticleCard({
    required String imageUrl,
    required String title,
    required String link,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke link
        Get.toNamed('/webview', arguments: link);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Text(
                link,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
