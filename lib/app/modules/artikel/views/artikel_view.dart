import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtikelView extends StatelessWidget {
  const ArtikelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF003D29),
      appBar: AppBar(
        backgroundColor: Color(0xFFEBE4DA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Artikel",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
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
              imageUrl: 'https://i.pinimg.com/736x/db/65/76/db6576a4763eae42a8c78d43bb478b21.jpg',
              title: 'Senaran kalori Buah-buahan dan sayuran yang sehat untuk kamu !!',
              link: 'https://www.kopas.com',
            ),
            SizedBox(height: 16),
            _buildArticleCard(
              imageUrl: 'https://via.placeholder.com/300x150',
              title: 'Terapkan kebiasaan ini untuk mulai hidup sehat anda sekarang !!',
              link: 'https://www.liputans.com',
            ),
            SizedBox(height: 16),
            _buildArticleCard(
              imageUrl: 'https://via.placeholder.com/300x150',
              title: 'Hindari makanan berikut jika anda ingin hidup lebih sehat !!',
              link: 'https://www.haidos.com',
            ),
          ],
        ),
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
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
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
     ),
);
}
}
