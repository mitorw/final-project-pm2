import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  var foodItems = [].obs;

  @override
  void onInit() {
    fetchFoodItems();
    super.onInit();
  }

  Future<void> fetchFoodItems() async {
    final url = Uri.parse('https://api.example.com/food-items'); // Ganti URL sesuai API Anda
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        foodItems.value = data.map((item) => FoodItem.fromJson(item)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch food items');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}

class FoodItem {
  final String name;
  final String calories;
  final String detail;

  FoodItem({required this.name, required this.calories, required this.detail});

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      calories: json['calories'],
      detail: json['detail'],
    );
  }
}
