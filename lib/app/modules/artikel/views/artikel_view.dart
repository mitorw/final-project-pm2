import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/home/views/home_view.dart';
import 'package:myapp/app/modules/food/views/food_view.dart';
import 'package:myapp/app/modules/history/views/history_view.dart';

class ArtikelView extends StatefulWidget {
  const ArtikelView({Key? key}) : super(key: key);

  @override
  State<ArtikelView> createState() => _ArtikelViewState();
}

class _ArtikelViewState extends State<ArtikelView> {
  int _currentIndex = 1; // Indeks default untuk Artikel

  void _onItemTapped(int index) async {
    if (index == _currentIndex) return; // Jika sudah terpilih, tidak perlu tindakan
    setState(() {
      _currentIndex = index; // Update indeks aktif
    });

    if (index == 0) {
      Get.off(() => const HomeView());
    } else if (index == 1) {
      Get.off(() => const ArtikelView());
    } else if (index == 2) {
      final selectedFood = await Get.to(() => FoodView());
      if (selectedFood != null) {}
    } else if (index == 3) {
      Get.off(() => const HistoryView());
    }
  }

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
              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs1XYSSNFpQxuc-OYRru-OUegkn6vwWw31_A&s',
              title: 'Senaran kalori Buah-buahan dan sayuran yang sehat untuk kamu !!',
              link: 'https://www.kopas.com',
              content: 'Buah-buahan dan sayuran adalah sumber kalori yang sangat baik...',
            ),
            const SizedBox(height: 16),
            _buildArticleCard(
              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMxjtNdPmV-qHNIeO4f439QrRDcu5Jd_YL7A&s',
              title: 'Terapkan kebiasaan ini untuk mulai hidup sehat anda sekarang !!',
              link: 'https://www.liputans.com',
              content: 'Mulailah hidup sehat dengan menerapkan kebiasaan sederhana...',
            ),
            const SizedBox(height: 16),
            _buildArticleCard(
              imageUrl: 'https://asset.kompas.com/crops/33cZFODwBUFwimy5yXpUCVVlQsQ=/1x1:978x652/1200x800/data/photo/2021/11/16/6193c223645d9.jpg',
              title: 'Hindari makanan berikut jika anda ingin hidup lebih sehat !!',
              link: 'https://www.haidos.com',
              content: 'Jika Anda ingin hidup lebih sehat, sebaiknya hindari...',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1F3826),
        selectedItemColor: const Color(0xFF1F3826),
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex, // Set currentIndex untuk menampilkan item terpilih
        onTap: _onItemTapped,
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
    required String content,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/placeholder.jpg',
                  fit: BoxFit.cover,
                  height: 150,
                );
              },
            ),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              content,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
