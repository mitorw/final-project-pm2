import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.dailyCalories.isEmpty) {
          return const Center(child: Text("No data available."));
        }

        return ListView.builder(
          itemCount: controller.dailyCalories.length,
          itemBuilder: (context, index) {
            final date = controller.dailyCalories.keys.toList()[index];
            final calories = controller.dailyCalories[date];

            return ListTile(
              title: Text(
                "${date.toLocal()}".split(' ')[0],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Calories: $calories"),
              onTap: () {
                controller.fetchFoodForDate(date); // Fetch makanan/minuman untuk tanggal yang dipilih
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Obx(() {
                      if (controller.selectedDateFoods.isEmpty) {
                        return const Center(child: Text("No food data for this date."));
                      }

                      return ListView.builder(
                        itemCount: controller.selectedDateFoods.length,
                        itemBuilder: (context, index) {
                          final food = controller.selectedDateFoods[index];
                          return ListTile(
                            title: Text(food['name'] ?? "Unknown food"),
                            subtitle: Text("Calories: ${food['calories'] ?? 0}"),
                          );
                        },
                      );
                    });
                  },
                );
              },
            );
          },
        );
      }),
    );
  }
}
