import 'package:flutter/material.dart';
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
                // Menampilkan Total Calories dan Calories Limit
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCalorieInfo(
                        "Total Calories Today",
                        "${controller.totalCaloriesToday} cal",
                        false,
                      ),
                      _buildCalorieInfo(
                        "Calories Limit",
                        "${2200 - controller.totalCaloriesToday} cal",
                        false,
                      ),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.foodList.length,
                itemBuilder: (context, index) {
                  final food = controller.foodList[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      leading: Icon(
                        Icons.food_bank,
                        color: Colors.orangeAccent,
                        size: 30,
                      ),
                      title: Text(
                        food['name'] ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        '${food['calories']} cal | ${food['weight']} g',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.grey[600],
                      ),
                      onTap: () {
                        // Add your onTap action here
                      },
                    ),
                  );
                },
              );
            }),
          ),
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
          BottomNavigationBarItem(icon: Icon(Icons.history_sharp), label: ''),
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
}
