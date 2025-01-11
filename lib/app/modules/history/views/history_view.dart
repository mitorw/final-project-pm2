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
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey.shade300,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.green.shade100,
        child: Obx(() {
          if (controller.dailyCalories.isEmpty) {
            return const Center(
              child: Text(
                "No data available.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.dailyCalories.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              final date = controller.dailyCalories.keys.toList()[index];
              final calories = controller.dailyCalories[date];

              return Card(
                color: Colors.green.shade300,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade800,
                    child: const Icon(Icons.calendar_today, color: Colors.white),
                  ),
                  title: Text(
                    "${date.toLocal()}".split(' ')[0],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Calories: $calories",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  onTap: () {
                    controller.fetchFoodForDate(date); // Fetch makanan/minuman untuk tanggal yang dipilih
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (_) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: Obx(() {
                            if (controller.selectedDateFoods.isEmpty) {
                              return const Center(
                                child: Text(
                                  "No food data for this date.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: controller.selectedDateFoods.length,
                              itemBuilder: (context, index) {
                                final food = controller.selectedDateFoods[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.green.shade200,
                                      child: const Icon(Icons.fastfood, color: Colors.white),
                                    ),
                                    title: Text(
                                      food['name'] ?? "Unknown food",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Calories: ${food['calories'] ?? 0}",
                                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
