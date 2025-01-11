import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var foodList = <Map<String, dynamic>>[].obs; // Observable list untuk realtime update

  @override
  void onInit() {
    super.onInit();
    listenToTodayMenu(); // Menggunakan listener realtime
  }

  // Fungsi untuk mendengarkan perubahan data secara realtime
  void listenToTodayMenu() {
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    _firestore
        .collection('menu')  // Pastikan koleksi yang digunakan adalah menu
        .where('addedAt', isGreaterThanOrEqualTo: startOfDay)
        .where('addedAt', isLessThanOrEqualTo: endOfDay)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .listen((querySnapshot) {
      // Mengupdate foodList secara realtime
      foodList.value = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;  // Menambahkan ID dokumen untuk penghapusan
        return data;
      }).toList();
    });
  }

  // Fungsi untuk menghapus makanan dari koleksi 'menu' di Firestore
  void deleteFood(String foodId) async {
    try {
      // Menghapus makanan dari koleksi 'menu' di Firestore berdasarkan foodId
      await _firestore.collection('menu').doc(foodId).delete();
    } catch (e) {
      print("Error deleting food: $e");
    }
  }

  // Menambahkan fungsi untuk mendapatkan total kalori hari ini
  int get totalCaloriesToday {
    return foodList.fold(0, (sum, food) {
      var calories = food['calories'];
      if (calories is int) {
        return sum + calories;
      } else if (calories is double) {
        return sum + calories.toInt();
      } else {
        return sum;
      }
    });
  }

  // Fungsi untuk menambahkan makanan ke foodList
  void addFoodToList(Map<String, dynamic> food) {
    foodList.add(food);
    update();
  }
}
