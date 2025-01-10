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
        .collection('menu')
        .where('addedAt', isGreaterThanOrEqualTo: startOfDay)
        .where('addedAt', isLessThanOrEqualTo: endOfDay)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .listen((querySnapshot) {
      // Perbarui foodList setiap kali ada perubahan di Firestore
      foodList.value = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  // Fungsi untuk menghitung total kalori pada hari ini
  int get totalCaloriesToday {
    DateTime now = DateTime.now();
    return foodList.fold(0, (sum, food) {
      // Memeriksa apakah food['addedAt'] berada pada tanggal yang sama dengan hari ini
      Timestamp addedAt = food['addedAt'];
      DateTime foodDate = addedAt.toDate();
      if (foodDate.year == now.year && foodDate.month == now.month && foodDate.day == now.day) {
        var calories = food['calories'];
        if (calories is int) {
          return sum + calories; // Jika 'calories' adalah int, tambahkan
        } else if (calories is double) {
          return sum + calories.toInt(); // Jika 'calories' adalah double, tambahkan
        }
      }
      return sum;
    });
  }

  // Tambahkan fungsi untuk menambahkan makanan ke daftar manual (jika diperlukan)
  void addFoodToList(Map<String, dynamic> food) {
    foodList.add(food);
    update();
  }
}
