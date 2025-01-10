import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var foodList = <Map<String, dynamic>>[].obs; // Observable list untuk realtime update

  @override
  void onInit() {
    super.onInit();
    listenToTodayMenu(); // Ubah metode ke realtime listener
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

  // Tambahkan fungsi untuk menambahkan makanan ke daftar manual (jika diperlukan)
  void addFoodToList(Map<String, dynamic> food) {
    foodList.add(food);
    update();
  }
}
