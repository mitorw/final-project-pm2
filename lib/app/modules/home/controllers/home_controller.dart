import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final foodList = <Map<String, dynamic>>[].obs;

  void addFoodToList(Map<String, dynamic> food) {
    foodList.add(food);
  }
  
}