import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 50),
                // Menambahkan logo
                Image.network(
                  'https://logospng.org/download/android/logo-android-4096.png',
                  height: 150,
                ),
                SizedBox(height: 20),
              ],
            ),
            TextField(
              controller: controller.cEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.cPass,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validasi sederhana
                if (controller.cEmail.text.isEmpty || controller.cPass.text.isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Email dan Password tidak boleh kosong",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  cAuth.signup(
                    controller.cEmail.text,
                    controller.cPass.text,
                  );
                }
              },
              child: Text("Sign Up"),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.toNamed('/login');
              },
              child: Text("Sudah punya akun? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
