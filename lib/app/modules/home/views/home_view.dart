import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:myapp/app/modules/artikel/views/artikel_view.dart';
import 'package:myapp/app/modules/food/views/food_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF003D29),
      appBar: AppBar(
        backgroundColor: Color(0xFFEBE4DA),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/image/okarun.jpg'),
            radius: 24,
          ),
        ),
        title: Text(
          "Hi, Okarun",
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
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's Count Your Calories Today !",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoBox("Weight"),
                    _buildInfoBox("Height"),
                    _buildInfoBox("Activity"),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCalorieInfo("Breakfast", "420 cal", true),
                      _buildCalorieInfo("Brunch", "200 cal", false),
                      _buildCalorieInfo("Calories Limit", "1500 cal", false),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: Obx(() {
              if (controller.foodList.isEmpty) {
                return Center(
                  child: Text(
                    "No food added yet.",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.foodList.length,
                itemBuilder: (context, index) {
                  final food = controller.foodList[index];
                  return _buildFoodItem(
                    food['name'],
                    '${food['calories']} cal',
                    '${food['weight']} g',
                  );
                },
              );
            }),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1F3826),
        selectedItemColor: Color(0xFF1F3826),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        onTap: (index) async {
          if (index == 1) {
            Get.to(() => ArtikelView());
          }
          if (index == 2) {
            final selectedFood = await Get.to(() => FoodView());
            if (selectedFood != null) {
              controller.addFoodToList(selectedFood); // Tambahkan makanan ke daftar
            }
          }
          if (index == 3) {
            Get.to(() => ArtikelView());
          }
          if (index == 4) {
            Get.to(() => ArtikelView());
          }
          // Tambahkan logika lainnya untuk tab yang lain
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String text) {
    return Expanded(
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildCalorieInfo(String title, String value, bool isSelected) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 14, color: isSelected ? Colors.green : Colors.black),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.green : Colors.black),
        ),
      ],
    );
  }

  Widget _buildFoodItem(String name, String calories, String weight) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
              image: DecorationImage(
                image: NetworkImage(
                    'https://via.placeholder.com/50'), // Ubah dengan URL dari Firebase
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '$calories | $weight',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {}, // Tambahkan logika untuk menghapus
            icon: Icon(Icons.remove_circle_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
