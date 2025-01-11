import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class FoodController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var searchResults = [].obs; 
  var currentIndex = 2.obs;

  void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

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

Future<void> addFoodToMenu(Map<String, dynamic> food) async {
  try {
    await _firestore.collection('menu').add({
      'name': food['name'] ?? 'Unknown', 
      'calories': food['calories'] ?? 0, 
      'weight': food['weight'] ?? 'No weight', 
      'addedAt': FieldValue.serverTimestamp(), 
    });

    Get.snackbar(
      'Success!',
      '${food['name']} has been added to the menu!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade600,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
    );
  } catch (e) {
    print('Error adding food to menu: $e');
    Get.snackbar(
      'Error!',
      'Failed to add ${food['name']} to the menu. Please try again.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      icon: const Icon(Icons.error, color: Colors.white),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}


  
}
