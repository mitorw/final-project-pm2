import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Variabel untuk menyimpan hasil pencarian
  var searchResults = [].obs; // Hasil pencarian
  var homeFoodList = [].obs;  // Daftar makanan di HomeView

  // Fungsi untuk mencari makanan berdasarkan nama
  void searchFood(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      // Query data dari Firestore berdasarkan nama makanan
      final result = await _firestore
          .collection('food')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      // Masukkan hasil pencarian ke dalam list
      searchResults.value = result.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  
  void addToHome(Map<String, dynamic> food) {
    homeFoodList.add(food);
  }
}
