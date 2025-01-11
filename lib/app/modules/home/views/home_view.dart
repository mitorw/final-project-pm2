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
            onPressed: () {},
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     _buildInfoBox("Weight"),
                //     _buildInfoBox("Height"),
                //     _buildInfoBox("Activity"),
                //   ],
                // ),
                // const SizedBox(height: 16),
                // Obx(() => Container(
                //       padding: const EdgeInsets.all(12),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(10),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.black.withOpacity(0.1),
                //             blurRadius: 10,
                //             offset: const Offset(0, 5),
                //           ),
                //         ],
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           _buildCalorieInfo(
                //             "Total Calories Today",
                //             "${controller.totalCaloriesToday.value} cal",
                //           ),
                //           _buildCalorieInfo(
                //             "Calories Limit",
                //             "${2200 - controller.totalCaloriesToday.value} cal",
                //           ),
                //         ],
                //       ),
                //     )),
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
                      onTap: () {
                      },
                    ),
                  );
                },
              );
            }),
          )
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

  // Widget _buildInfoBox(String text) {
  //   return Expanded(
  //     child: Container(
  //       height: 50,
  //       margin: const EdgeInsets.symmetric(horizontal: 4),
  //       decoration: BoxDecoration(
  //         color: Colors.grey.shade200,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Center(
  //         child: Text(
  //           text,
  //           style: const TextStyle(fontSize: 14, color: Colors.black),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildCalorieInfo(String title, String value) {
  //   return Column(
  //     children: [
  //       Text(
  //         title,
  //         style: const TextStyle(
  //           fontSize: 14,
  //           color: Colors.black,
  //         ),
  //       ),
  //       const SizedBox(height: 4),
  //       Text(
  //         value,
  //         style: const TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.black,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
