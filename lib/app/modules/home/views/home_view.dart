import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/artikel/views/artikel_view.dart';
import 'package:myapp/app/modules/food/views/food_view.dart';
import 'package:myapp/app/modules/history/views/history_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003D29),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBE4DA),
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/image/okarun.jpg'),
            radius: 24,
          ),
        ),
        title: const Text(
          "Hi, Okarun",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Trigger logout dialog when the settings icon is pressed
              _showLogoutDialog(context);
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's Count Your Calories Today!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (controller.foodList.isEmpty) {
                return const Center(
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      leading: const Icon(
                        Icons.food_bank,
                        color: Colors.orangeAccent,
                        size: 30,
                      ),
                      title: Text(
                        food['name'] ?? 'Unknown',
                        style: const TextStyle(
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
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.deleteFood(food['id']);
                        },
                      ),
                      onTap: () {},
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1F3826),
        selectedItemColor: const Color(0xFF1F3826),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        onTap: (index) async {
          if (index == 1) {
            Get.to(() => ArtikelView());
          }
          if (index == 2) {
            final selectedFood = await Get.to(() => FoodView());
            if (selectedFood != null) {
              controller.addFoodToList(selectedFood);
            }
          }
          if (index == 3) {
            Get.to(() => HistoryView());
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

  // Logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement your logout logic here
                Navigator.of(context).pop();
                // For example, clear user data and navigate to login page
                Get.offAllNamed('/login'); // Change '/login' to your login screen route
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
