import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var foodList = <Map<String, dynamic>>[].obs; 
  var totalCaloriesToday = 0.obs;
  var todayFoodList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenToTodayMenu(); 
  }

  void listenToTodayMenu() {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    _firestore
        .collection('menu') 
        .where('addedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('addedAt', isLessThanOrEqualTo: Timestamp.fromDate(endOfDay))
        .orderBy('addedAt', descending: true)
        .snapshots()
        .listen((querySnapshot) {
      // Mengupdate foodList secara realtime
      foodList.value = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; 
        return data;
      }).toList();
    });
  }

  void deleteFood(String foodId) async {
    try {
      await _firestore.collection('menu').doc(foodId).delete();
    } catch (e) {
      print("Error deleting food: $e");
    }
  }

void fetchTodayCalories() async {
  try {
    final startOfDay = Timestamp.fromDate(DateTime.now().subtract(Duration(
        hours: DateTime.now().hour,
        minutes: DateTime.now().minute,
        seconds: DateTime.now().second,
        milliseconds: DateTime.now().millisecond,
        microseconds: DateTime.now().microsecond)));
    final endOfDay = Timestamp.fromDate(DateTime.now().add(const Duration(hours: 23, minutes: 59, seconds: 59)));

    final querySnapshot = await _firestore
        .collection('menu')
        .where('addedAt', isGreaterThanOrEqualTo: startOfDay)
        .where('addedAt', isLessThanOrEqualTo: endOfDay)
        .get();

    todayFoodList.value =
        querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    print("Today Food List: $todayFoodList");

    totalCaloriesToday.value = todayFoodList.fold(
        0, (sum, food) => sum + (food['calories'] as num).toInt());

    print("Total Calories Today: ${totalCaloriesToday.value}");
  } catch (e) {
    print("Error fetching today's calories: $e");
  }
}

  void addFoodToList(Map<String, dynamic> food) {
    foodList.add(food);
    update();
  }
}
