import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FoodController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var searchResults = [].obs; // Hasil pencarian

  // Fungsi untuk mencari makanan berdasarkan nama
  void searchFood(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      final result = await _firestore
          .collection('food')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      searchResults.value = result.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Fungsi untuk menyimpan makanan ke koleksi 'menu' di Firestore
  Future<void> addFoodToMenu(Map<String, dynamic> food) async {
    try {
      await _firestore.collection('menu').add({
        'name': food['name'] ?? 'Unknown', // Nama makanan
        'calories': food['calories'] ?? 0, // Kalori makanan
        'weight': food['weight'] ?? 'No weight', // Berat makanan
        'addedAt': FieldValue.serverTimestamp(), // Waktu penambahan otomatis
      });

      Get.snackbar(
        'Success',
        '${food['name']} has been added to the menu!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error adding food to menu: $e');
      Get.snackbar(
        'Error',
        'Failed to add food to the menu. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFF0000),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  
}
