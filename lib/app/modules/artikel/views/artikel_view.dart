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
              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs1XYSSNFpQxuc-OYRru-OUegkn6vwWw31_A&s',
              title: 'Senaran kalori Buah-buahan dan sayuran yang sehat untuk kamu !!',
              link: 'https://www.kopas.com',
              content: 'Buah-buahan dan sayuran adalah sumber kalori yang sangat baik untuk mendukung gaya hidup sehat. Mereka tidak hanya kaya akan vitamin, mineral, dan serat, tetapi juga memberikan energi yang diperlukan tubuh tanpa menambah kalori berlebih. Beberapa buah seperti apel, pisang, dan jeruk, serta sayuran seperti bayam, brokoli, dan wortel, memberikan kalori yang seimbang dan nutrisi penting. Mengonsumsi berbagai jenis buah dan sayur setiap hari dapat membantu menjaga keseimbangan energi tubuh, meningkatkan metabolisme, serta mendukung sistem kekebalan tubuh. Memasukkan lebih banyak pilihan makanan alami ini ke dalam pola makan dapat memberikan manfaat jangka panjang bagi kesehatan.',
            ),
            const SizedBox(height: 16),
            _buildArticleCard(
              imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMxjtNdPmV-qHNIeO4f439QrRDcu5Jd_YL7A&s',
              title: 'Terapkan kebiasaan ini untuk mulai hidup sehat anda sekarang !!',
              link: 'https://www.liputans.com',
              content: 'Mulailah hidup sehat dengan menerapkan kebiasaan sederhana yang dapat meningkatkan kualitas hidup secara keseluruhan. Pertama, konsumsi lebih banyak buah dan sayuran setiap hari untuk memastikan tubuh mendapatkan nutrisi yang diperlukan. Pilih makanan alami yang rendah kalori namun kaya akan serat dan vitamin. Selain itu, perbanyak aktivitas fisik dengan rutin berolahraga, seperti berjalan kaki, bersepeda, atau yoga. Jangan lupa untuk cukup tidur, karena tidur yang berkualitas sangat berperan dalam pemulihan tubuh dan keseimbangan hormon. Batasi konsumsi makanan olahan dan gula berlebih, serta minum air putih secara cukup untuk menjaga tubuh tetap terhidrasi. Dengan membiasakan diri menjalani gaya hidup sehat ini, Anda akan merasakan peningkatan energi, kebugaran, dan kualitas hidup yang lebih baik.',
            ),
            const SizedBox(height: 16),
            _buildArticleCard(
              imageUrl: 'https://asset.kompas.com/crops/33cZFODwBUFwimy5yXpUCVVlQsQ=/1x1:978x652/1200x800/data/photo/2021/11/16/6193c223645d9.jpg',
              title: 'Hindari makanan berikut jika anda ingin hidup lebih sehat !!',
              link: 'https://www.haidos.com',
              content: 'Jika Anda ingin hidup lebih sehat, sebaiknya hindari beberapa jenis makanan yang dapat membahayakan kesehatan tubuh. Pertama, makanan olahan tinggi gula, seperti permen, minuman manis, dan makanan ringan kemasan, dapat meningkatkan risiko obesitas, diabetes, dan penyakit jantung. Kedua, makanan tinggi lemak jenuh dan trans, seperti gorengan, makanan cepat saji, dan produk olahan daging, dapat mempengaruhi kesehatan jantung dan meningkatkan kadar kolesterol jahat dalam darah. Selain itu, batasi konsumsi makanan tinggi garam, seperti makanan kaleng atau makanan instan, yang dapat menyebabkan hipertensi dan masalah ginjal. Terakhir, hindari alkohol berlebihan dan makanan yang mengandung bahan pengawet atau zat kimia berbahaya, karena dapat merusak organ tubuh dan mengurangi sistem kekebalan tubuh. Menghindari makanan tersebut akan membantu Anda menjaga tubuh tetap sehat dan bugar.',
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
            Get.off(() => HomeView());
          }
          if (index == 1) {
            Get.off(() => ArtikelView());
          }
          if (index == 2) {
            final selectedFood = await Get.to(() => FoodView());
            if (selectedFood != null) {}
          }
          if (index == 3) {
            Get.off(() => HistoryView());
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
