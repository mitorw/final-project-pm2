import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var dailyCalories = <DateTime, int>{}.obs;
  var selectedDateFoods = <Map<String, dynamic>>[].obs;
  var currentIndex = 3.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDailyCalories();
  }

void updateCurrentIndex(int index) {
    currentIndex.value = index;
  }

void fetchDailyCalories() async {
  final querySnapshot = await _firestore.collection('menu').get();

  Map<DateTime, int> tempDailyCalories = {};
  for (var doc in querySnapshot.docs) {
    final data = doc.data();
    final timestamp = data['addedAt'] as Timestamp?;
    final calories = data['calories'];

    if (timestamp != null && (calories is int || calories is double)) {
      final date = DateTime(
        timestamp.toDate().year,
        timestamp.toDate().month,
        timestamp.toDate().day,
      );

      tempDailyCalories[date] = (tempDailyCalories[date] ?? 0) + (calories as num).toInt();
    }
  }

  dailyCalories.value = tempDailyCalories;
}


  void fetchFoodForDate(DateTime date) async {
    final startOfDay = Timestamp.fromDate(DateTime(date.year, date.month, date.day, 0, 0, 0));
    final endOfDay = Timestamp.fromDate(DateTime(date.year, date.month, date.day, 23, 59, 59));

    final querySnapshot = await _firestore
        .collection('menu')
        .where('addedAt', isGreaterThanOrEqualTo: startOfDay)
        .where('addedAt', isLessThanOrEqualTo: endOfDay)
        .get();

    selectedDateFoods.value = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}
