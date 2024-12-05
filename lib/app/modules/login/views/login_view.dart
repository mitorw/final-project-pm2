import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                // Menambahkan logo
                Image.network(
                  'https://logospng.org/download/android/logo-android-4096.png', // Ganti dengan path gambar logo kamu
                  height: 150, // Atur ukuran logo sesuai kebutuhan
                ),
                SizedBox(height: 20), // Jarak antara logo dan form
              ],
            ),
            TextField(
              controller: controller.cEmail,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: controller.cPass,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                cAuth.login(
                  controller.cEmail.text,
                  controller.cPass.text,
                );
              },
              child: Text("Login"),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.RESET_PASSWORD);
                },
                child: Text("Reset Password"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum Punya Akun ?"),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.REGISTER);
                  },
                  child: Text("Daftar Disini"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
