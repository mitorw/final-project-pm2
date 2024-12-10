import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height: MediaQuery.of(context).size.height / 3, // Gambar menempati 1/3 layar
            width: double.infinity,
            child: Image.asset(
              'assets/image/mockup.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            color: const Color(0x113826).withOpacity(0.4), // Overlay gambar dengan 60% opacity
          ),
          // Content Overlay
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 2.5), // Spacer untuk memastikan teks di bawah gambar
                  Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12), // Jarak antara judul dan deskripsi
                  Text(
                    '"Buat akun Anda untuk mulai menghitung kalori dan mencapai tujuan kesehatan Anda!"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32), // Jarak sebelum form input
                  TextField(
                    controller: controller.cEmail,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller.cPass,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.cEmail.text.isEmpty ||
                          controller.cPass.text.isEmpty) {
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E20),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/login');
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: 'Sudah punya akun? ',
                        style: TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                    icon: Image.asset(
                      'assets/image/google.png',
                      height: 24,
                      width: 24,
                    ),
                    label: const Text(
                      'Sign up with Google',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E20),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(
                            color: Colors.grey), // Border abu-abu
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
